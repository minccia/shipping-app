class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show start]
  before_action :require_admin, only: %i[new create]
  before_action :fetch_service_order, only: %i[show start finish]
  before_action :fetch_transport_modality, only: %i[start]
  before_action :ensure_transport_modality_has_available_vehicles_before_alocating, only: %i[start]
  
  def index 
    @service_orders = ServiceOrder.pending
  end

  def in_progress
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
    started_so = @service_order.build_started(transport_modality: @transport_modality,
                                              vehicle: @vehicle, due_date: due_date, value: value)
 
    if started_so.save 
      @service_order.in_progress!
      @vehicle.in_operation!
      return redirect_to @service_order, notice: t('service_order_initiated_with_success')
    end
    return redirect_to @service_order, notice: t('service_order_not_started')
  end

  def finish 
    return redirect_to root_path if @service_order.started.nil? || @service_order.finished?

    finished_so = @service_order.build_finished(delivery_date: Date.today)
  
    @service_order.finished!
    @service_order.started.vehicle.available!
    
    if finished_so.delivery_was_late?
      return redirect_to new_service_order_lateness_explanation_url(@service_order.id)
    end
    return redirect_to @service_order, notice: t('service_order_finished_with_success')
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

    def ensure_transport_modality_has_available_vehicles_before_alocating
      vehicles = @transport_modality.vehicles.available 
      if vehicles.any? 
        @vehicle = vehicles.sample
      else  
        flash.notice = t('no_vehicles_available', trans_mod: @transport_modality.name)
        return redirect_to service_order_url(@service_order.id)
      end
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