require 'rails_helper'

RSpec.describe TableEntry, type: :model do
  describe '#valid?' do 
    it 'false when first interval is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   second_interval: 1, value: 5, 
                                   weight_price_table: trans_mod.weight_price_table
                                 )
    
      table_entry.save 

      expect table_entry.errors.include? :first_interval
    end

    it 'false when second interval is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   first_interval: 3, value: 10,
                                   weight_price_table: trans_mod.weight_price_table
                                 )
    
      table_entry.save 

      expect table_entry.errors.include? :second_interval
    end

    it 'false when price is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   first_interval: 3, value: 10,
                                   weight_price_table: trans_mod.weight_price_table
                                 )

      table_entry.save
    
      expect table_entry.errors.include? :value
    end

  end

  describe '#fetch_table' do 
    it 'return correct table when table entry is from weight price table' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(first_interval: 0,
                                   second_interval: 50,
                                   value: 30.0,
                                   weight_price_table: trans_mod.weight_price_table
                                  )
                      
      expect(table_entry.fetch_table).to eq trans_mod.weight_price_table
    end

    it 'return correct table when table entry is from distance price table' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(first_interval: 0,
                                   second_interval: 50,
                                   value: 30.0,
                                   distance_price_table: trans_mod.distance_price_table
                                  )
                      
      expect(table_entry.fetch_table).to eq trans_mod.distance_price_table
    end

    it 'return correct table when table entry is from freight table' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(first_interval: 0,
                                   second_interval: 50,
                                   value: 30.0,
                                   freight_table: trans_mod.freight_table
                                  )
                      
      expect(table_entry.fetch_table).to eq trans_mod.freight_table
    end
  end
end
