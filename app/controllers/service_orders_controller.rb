class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :require_admin, only: %i[new create]
  before_action :fetch_service_order, only: %i[show start finish]
  before_action :fetch_transport_modality, only: %i[start]
  before_action :alocate_vehicle, only: %i[start]
  
  def index 
    @service_orders = ServiceOrder.pending
  end

  def in_operation 
    @service_orders = ServiceOrder.in_progress
    render :index
  end

  def new 
    @service_order = ServiceOrder.new
  end

  def create
    @service_order = ServiceOrder.new new_service_order_params
    if @service_order.save
      flash.notice = "#{ServiceOrder.model_name.human} #{ t 'created_with_success' }"
      return redirect_to service_orders_path
    end
    flash.notice = "#{ServiceOrder.model_name.human} #{ t 'not_created' }"
    render :new, status: :unprocessable_entity
  end

  def show; end

  def start 
    value = @transport_modality.so_execution_price(@service_order)
    due_date = @transport_modality.so_execution_due_date(@service_order).to_i
    started_so = StartedServiceOrder.new(service_order: @service_order, vehicle: @vehicle,
                                         transport_modality: @transport_modality, due_date: due_date,
                                         value: value
                                        )
    if started_so.save 
      @service_order.in_progress!
      @vehicle.in_operation!
      return redirect_to service_order_url(@service_order.id), notice: t('service_order_initiated_with_success')
    end
  end

  def finish 
    finished_so = FinishedServiceOrder.create(service_order: @service_order,
                                           delivery_date: Date.today)
    @service_order.finished!
    @service_order.started.vehicle.available!
    return redirect_to new_service_order_lateness_explanation_path(@service_order.id) if finished_so.delivery_was_late?
    return redirect_to service_order_url(@service_order.id), notice: t('service_order_finished_with_success')
  end

  def search 
    @searched_term = params[:query]
    @found_service_orders = ServiceOrder.where("package_code LIKE ?", "%#{@searched_term}%")

    if @found_service_orders.empty?
      flash.notice = t('no_service_orders_found')
      return redirect_to root_url
    end
  end

  private 

    def fetch_service_order
      @service_order = ServiceOrder.find params[:id]
    end

    def fetch_transport_modality
      @transport_modality = TransportModality.find params[:transport_modality_id]
    end

    def alocate_vehicle
      @vehicle = @transport_modality.vehicles.available.sample
    end

    def new_service_order_params
      params.require(:service_order).permit(
        :sender_full_address, :sender_zip_code,
        :package_height, :package_width, :package_depth,
        :package_weight, :receiver_name, :receiver_full_address,
        :receiver_zip_code, :distance
      )
    end

end