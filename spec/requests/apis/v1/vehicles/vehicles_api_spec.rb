require 'rails_helper'

describe 'Vehicles API' do 
  context 'GET /api/v1/vehicles' do 
    it 'list all vehicles' do 

      trans_mod = FactoryBot.create(:transport_modality)
      FactoryBot.create(
                       :vehicle, license_plate: 'ABC1D23',
                       brand_name: 'Toyota', vehicle_type: 'Fusca',
                       fabrication_year: '2005', maximum_capacity: 500,
                       transport_modality: trans_mod
                      )
      FactoryBot.create(
                        :vehicle, license_plate: 'ABD1X89',
                        brand_name: 'Fiat', vehicle_type: 'Carro',
                        fabrication_year: '2010', maximum_capacity: 550,
                        transport_modality: trans_mod
                      )

      get '/api/v1/vehicles'

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json' 

      json_data = JSON.parse(response.body)

      expect(json_data.length).to eq 2 
      expect(json_data.first["license_plate"]).to eq 'ABC1D23'
      expect(json_data.first["brand_name"]).to eq 'Toyota'
      expect(json_data.first["vehicle_type"]).to eq 'Fusca'
      expect(json_data.first["fabrication_year"]).to eq '2005'
      expect(json_data.first["maximum_capacity"]).to eq 500
      expect(json_data.first["transport_modality_id"]).to eq 1
      expect(json_data[1]["license_plate"]).to eq 'ABD1X89'
      expect(json_data[1]["brand_name"]).to eq 'Fiat'
      expect(json_data[1]["vehicle_type"]).to eq 'Carro'
      expect(json_data[1]["fabrication_year"]).to eq '2010'
      expect(json_data[1]["maximum_capacity"]).to eq 550
      expect(json_data[1]["transport_modality_id"]).to eq 1
      expect(json_data.first.keys).not_to include "created_at"
      expect(json_data.first.keys).not_to include "updated_at"
      expect(json_data[1].keys).not_to include "created_at"
      expect(json_data[1].keys).not_to include "updated_at"
    end

    it 'and returns empty when there are no vehicles' do 
      get '/api/v1/vehicles'

      expect(response).to have_http_status 200 
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response).to eq []
    end

    it 'and happens an internal error' do 
      trans_mod = FactoryBot.create(:transport_modality)
      FactoryBot.create(
                       :vehicle, license_plate: 'ABC1D23',
                       brand_name: 'Toyota', vehicle_type: 'Fusca',
                       fabrication_year: '2005', maximum_capacity: 500,
                       transport_modality: trans_mod
                      )
      FactoryBot.create(
                        :vehicle, license_plate: 'ABD1X89',
                        brand_name: 'Fiat', vehicle_type: 'Carro',
                        fabrication_year: '2010', maximum_capacity: 550,
                        transport_modality: trans_mod
                      )
      allow(Vehicle).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/vehicles'

      expect(response).to have_http_status 500
    end
  end

  context 'GET /api/v1/vehicles/1' do 
    it 'list information from a single vehicle' do 
      trans_mod = FactoryBot.create(:transport_modality)
      target_vehicle = FactoryBot.create(
                                          :vehicle, license_plate: 'ABC1D23',
                                          brand_name: 'Toyota', vehicle_type: 'Fusca',
                                          fabrication_year: '2005', maximum_capacity: 500,
                                          transport_modality: trans_mod
                                         )
      FactoryBot.create(
                        :vehicle, license_plate: 'ABD1X89',
                        brand_name: 'Fiat', vehicle_type: 'Carro',
                        fabrication_year: '2010', maximum_capacity: 550,
                        transport_modality: trans_mod
                      )
      
      get "/api/v1/vehicles/#{target_vehicle.id}"

      expect(response).to have_http_status 200 
      expect(response.content_type).to include 'application/json'

      json_data = JSON.parse(response.body)
      
      expect([json_data].length).to eq 1 
      expect(json_data["license_plate"]).to eq 'ABC1D23'
      expect(json_data["brand_name"]).to eq 'Toyota'
      expect(json_data["vehicle_type"]).to eq 'Fusca'
      expect(json_data["fabrication_year"]).to eq '2005'
      expect(json_data["maximum_capacity"]).to eq 500
      expect(json_data["transport_modality_id"]).to eq 1
    end

    it 'and there is no vehicle with the received id' do 
      
      allow(Vehicle).to receive(:find).with('blablablabluble99999').and_raise(ActiveRecord::RecordNotFound)

      get '/api/v1/vehicles/blablablabluble99999'

      expect(response).to have_http_status 404
    end

    it 'and happens an internal error' do 

      trans_mod = FactoryBot.create(:transport_modality)
      target_vehicle = FactoryBot.create(
                                          :vehicle, license_plate: 'ABC1D23',
                                          brand_name: 'Toyota', vehicle_type: 'Fusca',
                                          fabrication_year: '2005', maximum_capacity: 500,
                                          transport_modality: trans_mod
                                         )

      allow(Vehicle).to receive(:find).with("#{target_vehicle.id}").and_raise(ActiveRecord::QueryCanceled)    

      get "/api/v1/vehicles/#{target_vehicle.id}"

      expect(response).to have_http_status 500
    end


  end
end