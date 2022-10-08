require 'rails_helper'

RSpec.describe TransportModality, type: :model do
  subject(:transport_modality) { FactoryBot.build(:transport_modality) }

  describe '#valid?' do
    context 'Presence validation is' do 
      it 'false when name is empty' do 
        transport_modality.name = nil 

        transport_modality.valid?

        expect(transport_modality.errors.include? :name).to be_truthy
      end

      it 'false when maximum distance is empty' do 
        transport_modality.maximum_distance = nil 

        transport_modality.valid?

        expect(transport_modality.errors.include? :maximum_distance).to be_truthy
      end

      it 'false when maximum weight is empty' do 
        transport_modality.maximum_weight = nil 

        transport_modality.valid?

        expect(transport_modality.errors.include? :maximum_weight).to be_truthy
      end

      it 'false when fee is empty' do 
        transport_modality.fee = nil 

        transport_modality.valid?

        expect(transport_modality.errors.include? :fee).to be_truthy
      end
    end
  end

end
