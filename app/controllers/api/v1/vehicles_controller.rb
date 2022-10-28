class Api::V1::VehiclesController < Api::V1::ApiController

  def index 
    render status: 200, json: parse_json(Vehicle.all)
  end

  def show 
    vehicle = Vehicle.find params[:id]
    render status: 200, json: parse_json(vehicle)
  end
end