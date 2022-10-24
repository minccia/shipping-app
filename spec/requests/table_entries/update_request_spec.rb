require 'rails_helper'

describe 'User updates table entry' do 
  it 'unless it is not authenticated as an admin' do 
    trans_mod = FactoryBot.create(:transport_modality)
    table_entry = FactoryBot.create(:table_entry, weight_price_table: trans_mod.weight_price_table)

    patch "/table_entries/#{table_entry.id}", params: { table_entry: { first_interval: 2 } }

    expect(response).to redirect_to root_path
  end
end