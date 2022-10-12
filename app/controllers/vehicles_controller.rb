class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: %i[index search]
  before_action :require_admin, only: %i[new edit update send_to_maintenance]
  before_action :fetch_vehicle, only: %i[show edit update send_to_maintenance]

  def index; end 

  def new 
    @vehicle = Vehicle.new
  end

  def create 
    @vehicle = Vehicle.new new_vehicle_params
    if @vehicle.save 
      flash.notice = t 'messages.vehicle_created_with_success'
      return redirect_to vehicles_url
    end
    flash.now.notice = t 'messages.vehicle_not_created'
    render :new, status: :unprocessable_entity
  end

  def search 
    @searched_term = params[:query]
    @found_vehicles = Vehicle.joins(:transport_modality).where(
      transport_modality: {name: "#{@searched_term}"}).or(
      Vehicle.where("license_plate LIKE ?", "%#{@searched_term}%")
    )

    if @found_vehicles.empty? 
      flash.notice = t 'messages.no_vehicles_found'
      return redirect_to vehicles_url
    end
  end

  def show; end

  def send_to_maintenance 
    if @vehicle.on_maintenance?
      flash.notice = t 'messages.vehicle_already_in_maintenance', license_plate: @vehicle.license_plate
      return redirect_to vehicles_url
    end
    @vehicle.on_maintenance!
    flash.notice = t 'messages.sent_to_maintenance', license_plate: @vehicle.license_plate
    return redirect_to vehicles_url
  end

  def edit; end

  def update 
    if @vehicle.update new_vehicle_params
      flash.notice = t 'messages.vehicle_updated_with_success'
      return redirect_to vehicle_url(@vehicle)
    end
    flash.notice = t 'messages.vehicle_not_updated'
    render :edit, status: :unprocessable_entity
  end
  private 

    def fetch_vehicle
      @vehicle = Vehicle.find params[:id]
    end

    def new_vehicle_params 
      params.require(:vehicle).permit(
        :license_plate, :brand_name, :vehicle_type,
        :fabrication_year, :maximum_capacity,
        :transport_modality_id
      )
    end
end