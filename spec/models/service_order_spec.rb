require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  subject(:order) { FactoryBot.build(:service_order) }

  describe '#valid?' do 
    context 'Presence validation is' do 
      it 'false when sender_full_address is empty' do 
        order.sender_full_address = nil 
  
        expect(order).to be_invalid
      end
  
      it 'false when sender_zip_code is empty' do 
        order.sender_zip_code = nil
  
        expect(order).to be_invalid
      end
  
      it 'false when package_height is empty' do 
        order.package_height = nil 
  
        expect(order).to be_invalid
      end

      it 'false when package_width is empty' do 
        order.package_width = nil 

        expect(order).to be_invalid
      end

      it 'false when package_depth is empty' do 
        order.package_depth = nil 

        expect(order).to be_invalid
      end

      it 'false when package_weight is empty' do 
        order.package_weight = nil 

        expect(order).to be_invalid
      end

      it 'false when receiver_name is empty' do 
        order.receiver_name = nil 

        expect(order).to be_invalid
      end

      it 'false when receiver_full_address is empty' do 
        order.receiver_full_address = nil 

        expect(order).to be_invalid 
      end

      it 'false when receiver_zip_code is empty' do 
        order.receiver_zip_code = nil 

        expect(order).to be_invalid
      end

      it 'false when distance is empty' do 
        order.distance = nil 

        expect(order).to be_invalid
      end
    end
  end

end
