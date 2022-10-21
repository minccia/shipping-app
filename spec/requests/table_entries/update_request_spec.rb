require 'rails_helper'

describe 'User updates table entry' do 
  it 'unless it is not authenticated as an admin' do 
    table_entry = TableEntry.create!(
                                     first_interval: 0,
                                     second_interval: 1,
                                     value: 10
                                    )

    patch "/table_entries/#{table_entry.id}", params: { table_entry: { first_interval: 2 } }

    expect(response).to redirect_to root_path
  end
end