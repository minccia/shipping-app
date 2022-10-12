class TransportModalitiesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :require_admin, only: %i[new create edit update]
  before_action :fetch_transport_modalities, only: %i[index create]
  before_action :locate_trans_modal_by_id, only: %i[show edit update]

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

  def show; end

  def edit; end

  def update 
    if @transport_modality.update new_trans_modal_params
      flash.notice = t 'modality_updated_with_success'
      return redirect_to transport_modalities_url 
    end
    flash.now.notice = t 'modality_not_updated'
    render :edit, status: :unprocessable_entity
  end

  private 

    def locate_trans_modal_by_id 
      @transport_modality = TransportModality.find params[:id]
    end

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

