require 'rails_helper'

describe 'Shipping API' do 
  context 'GET /api/v1/transport_modalities/1' do 
    it 'success' do 
      transport_modality = TransportModality.create!(
                                                      name: 'Ghetto Expresso',
                                                      minimum_distance: 10,
                                                      maximum_distance: 100,
                                                      minimum_weight: 100,
                                                      maximum_weight: 10000,
                                                      fee: 19.5
                                                    )

      get "/api/v1/transport_modalities/#{transport_modality.id}"

      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq 'Ghetto Expresso' 
      expect(json_response["minimum_distance"]).to eq 10
      expect(json_response["maximum_distance"]).to eq 100
      expect(json_response["minimum_weight"]).to eq 100
      expect(json_response["maximum_weight"]).to eq 10000
      expect(json_response["fee"]).to eq 19.50
      expect(json_response.keys).not_to include "created_at"
      expect(json_response.keys).not_to include "updated_at"
    end

    it 'fail if warehouse not found' do 
      get "/api/v1/transport_modalities/blablabla9999999"

      expect(response.status).to eq 404
    end

    it 'and raise internal error' do 
      allow(TransportModality).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)
      transport_modality = FactoryBot.create(:transport_modality)

      get "/api/v1/transport_modalities/#{transport_modality.id}"

      expect(response).to have_http_status(500)
    end

  end

  context 'GET /api/v1/transport_modalities' do 
    it 'list all transport modalities' do 
      first_trans = TransportModality.create!(
                                              name: 'Ghetto Expresso',
                                              minimum_distance: 10,
                                              maximum_distance: 100,
                                              minimum_weight: 100,
                                              maximum_weight: 10000,
                                              fee: 19.5
                                            )

      second_trans = TransportModality.create!(
                                                name: 'Busão do João',
                                                minimum_distance: 20,
                                                maximum_distance: 300,
                                                minimum_weight: 10,
                                                maximum_weight: 9999,
                                                fee: 0.4
                                            )

      get '/api/v1/transport_modalities'

      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 2 
      expect(json_response.first["name"]).to eq 'Ghetto Expresso'
      expect(json_response.first["minimum_distance"]).to eq 10 
      expect(json_response.first["maximum_distance"]).to eq 100
      expect(json_response[1]["name"]).to eq 'Busão do João'
      expect(json_response[1]["minimum_distance"]).to eq 20
      expect(json_response[1]["maximum_distance"]).to eq 300
    end

    it 'return empty if there are no transport modalities' do 
      get '/api/v1/transport_modalities'

      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response).to eq []
    end

    it 'and raise internal error' do 
      allow(TransportModality).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/transport_modalities'

      expect(response.status).to eq 500
    end
  end

  context 'POST /api/v1/transport_modalities' do 
    it 'success' do 
      new_trans_params = { 
                          transport_modality: { name: 'Ghetto Expresso',
                                                maximum_distance: 20,
                                                maximum_weight: 2, 
                                                fee: 19.5             }   
                          }

      post '/api/v1/transport_modalities', params: new_trans_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq 'Ghetto Expresso' 
      expect(json_response["maximum_distance"]).to eq 20
      expect(json_response["maximum_weight"]).to eq 2
      expect(json_response["fee"]).to eq 19.50
      expect(json_response.keys).not_to include "created_at"
      expect(json_response.keys).not_to include "updated_at"
    end

    it 'fail if parameters are not completed' do 
      new_trans_params = { transport_modality: { name: 'Ghetto Expresso' } }

      post '/api/v1/transport_modalities', params: new_trans_params

      expect(response).to have_http_status(412)
      expect(response.body).not_to include 'Nome não pode ficar em branco'
      expect(response.body).to include 'Distância máxima praticada não pode ficar em branco'
      expect(response.body).to include 'Peso máximo da carga não pode ficar em branco'
      expect(response.body).to include 'Taxa fixa não pode ficar em branco'
    end

    it 'fail if there is an internal error' do 
      allow(TransportModality).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      new_trans_params = { 
                          transport_modality: { name: 'Ghetto Expresso',
                                                maximum_distance: 20,
                                                maximum_weight: 2, 
                                                fee: 19.5             }   
                          }

      post '/api/v1/transport_modalities', params: new_trans_params

      expect(response).to have_http_status(500)
    end
  end

end