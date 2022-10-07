class TransportModalitiesController < ApplicationController
  before_action :fetch_transport_modalities, only: %i[index create]
  before_action :require_admin, only: %i[index]

  def index 
    @transport_modality = TransportModality.new
  end

  def create 
    @transport_modality = TransportModality.new new_trans_modal_params
    if @transport_modality.save 
      flash.notice = t 'modality_created_with_success'
      return redirect_to transport_modalities_url
    end
    flash.now.notice =  t 'modality_not_created'
    render :index, status: :unprocessable_entity 
  end

  private 

    def fetch_transport_modalities 
      @transport_modalities = TransportModality.all 
    end
    
    def new_trans_modal_params
      params.require(:transport_modality).permit(
        :name, :minimum_distance, :maximum_distance,
        :minimum_weight, :maximum_weight, :fee, :active
      )
    end
end

