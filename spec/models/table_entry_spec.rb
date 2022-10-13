require 'rails_helper'

RSpec.describe TableEntry, type: :model do
  describe '#valid?' do 
    it 'false when first interval is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   second_interval: 1, price: 5, 
                                   weight_price_table: trans_mod.weight_price_table
                                 )
    
      table_entry.save 

      expect table_entry.errors.include? :first_interval
    end

    it 'false when second interval is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   first_interval: 3, price: 10,
                                   weight_price_table: trans_mod.weight_price_table
                                 )
    
      table_entry.save 

      expect table_entry.errors.include? :second_interval
    end

    it 'false when price is empty' do 
      trans_mod = FactoryBot.create(:transport_modality)
      table_entry = TableEntry.new(
                                   first_interval: 3, price: 10,
                                   weight_price_table: trans_mod.weight_price_table
                                 )

      table_entry.save
    
      expect table_entry.errors.include? :price
    end

  end
end
