require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  subject(:vehicle) { FactoryBot.build(:vehicle) }

  describe '#valid?' do 
    it 'false when license_plate is empty' do 
      vehicle.license_plate = nil 

      vehicle.valid?

      expect(vehicle.errors.include? :license_plate).to be_truthy
    end
    
    it 'false when brand_name is empty' do 
      vehicle.brand_name = nil 
  
      vehicle.valid?
  
      expect(vehicle.errors.include? :brand_name).to be_truthy
    end

    it 'false when vehicle_type is empty' do 
      vehicle.vehicle_type = nil 
  
      vehicle.valid?
  
      expect(vehicle.errors.include? :vehicle_type).to be_truthy
    end

    it 'false when fabrication_year is empty' do 
      vehicle.fabrication_year = nil 
  
      vehicle.valid?
  
      expect(vehicle.errors.include? :fabrication_year).to be_truthy
    end

    it 'false when maximum_capacity is empty' do 
      vehicle.maximum_capacity = nil 
  
      vehicle.valid?
  
      expect(vehicle.errors.include? :maximum_capacity).to be_truthy
    end
  end
end
