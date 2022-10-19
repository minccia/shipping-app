class LatenessExplanationsController < ApplicationController
  before_action :fetch_finished_service_order, only: %i[create]

  def new
    @lateness_explanation = LatenessExplanation.new
  end

  def create 
    lateness_explanation = @finished_so.build_lateness_explanation new_explanation_params

    if lateness_explanation.save 
      flash.notice = t('service_order_finished_with_success')
      return redirect_to service_order_path(params[:service_order_id])
    end
    flash.notice = t('justification_cant_be_blank')
    return redirect_to new_service_order_lateness_explanation_path(params[:service_order_id])
  end

  private 

    def fetch_finished_service_order
      @finished_so = (ServiceOrder.find params[:service_order_id]).finished
    end

    def new_explanation_params 
      params.require(:lateness_explanation).permit(:justification)
    end
end