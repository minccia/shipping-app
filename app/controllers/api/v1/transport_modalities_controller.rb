class Api::V1::TransportModalitiesController < Api::V1::ApiController

  def index  
    render status: 200, json: parse_json(TransportModality.all)
  end

  def show 
    transport_modality = TransportModality.find params[:id]
    return render status: 200, json: parse_json(transport_modality)
  end

  def create 
    transport_modality = TransportModality.new new_tm_params  
    return render status: 201, json: parse_json(transport_modality) if transport_modality.save  
    render status: 412, json: { errors: transport_modality.errors.full_messages } 
  end

  private 

    def new_tm_params
      params.require(:transport_modality).permit(
        :name, :minimum_distance, :maximum_distance,
        :minimum_weight, :maximum_weight, :fee
      )
    end
    
    def parse_json(object)
      object.as_json(except: [:created_at, :updated_at])
    end

end