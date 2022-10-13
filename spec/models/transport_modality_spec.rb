require 'rails_helper'

RSpec.describe TransportModality, type: :model do
  describe '#valid?' do 
    let(:transport_modality) { FactoryBot.create(:transport_modality) }

    it 'false when name is empty' do 
      transport_modality.name = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :name
    end

    it 'false when minimum_distance is empty' do 
      transport_modality.minimum_distance = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :minimum_distance
    end

    it 'false when maximum_distance is empty' do 
      transport_modality.maximum_distance = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :maximum_distance
    end

    it 'false when minimum_weigh is empty' do 
      transport_modality.minimum_weight = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :minimum_weigh
    end

    it 'false when maximum_weight is empty' do 
      transport_modality.maximum_weight = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :maximum_weight
    end

    it 'false when fee is empty' do 
      transport_modality.fee = nil 

      transport_modality.save 

      expect transport_modality.errors.include? :fee
    end

    it 'false when active is not a valid option' do 
      transport_modality.active = 'BUMBA MEU BOI'

      transport_modality.save 

      expect transport_modality.errors.include? :active
    end
  end
end
