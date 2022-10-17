class LatenessExplanationsController < ApplicationController
  before_action :fetch_finished_service_order, only: %i[create]

  def new
    @lateness_explanation = LatenessExplanation.new
  end

  def create 
    lateness_explanation = LatenessExplanation.new new_explanation_params
    lateness_explanation.finished_service_order_id = @finished_so.id
    if lateness_explanation.save 
      flash.notice = t('service_order_finished_with_success')
      return redirect_to service_order_path(@finished_so.service_order.id)
    end
  end

  private 

    def fetch_finished_service_order
      @finished_so = (ServiceOrder.find params[:service_order_id]).finished
    end

    def new_explanation_params 
      params.require(:lateness_explanation).permit(:justification)
    end
end