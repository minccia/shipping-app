class ServiceOrdersController < ApplicationController
  def index 
    @service_orders = ServiceOrder.all 
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

  def show 
    @service_order = ServiceOrder.find params[:id]
  end

  private 

    def new_service_order_params
      params.require(:service_order).permit(
        :sender_full_address, :sender_zip_code,
        :package_height, :package_width, :package_depth,
        :package_weight, :receiver_name, :receiver_full_address,
        :receiver_zip_code, :distance
      )
    end

end