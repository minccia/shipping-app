require 'rails_helper'

describe 'User create new table entry' do 
  it 'unless it is not authenticated as an admin' do 
    post '/table_entries', params: { table_entry: { first_interval: 1 } }
  
    expect(response).to redirect_to root_path
  end  
end