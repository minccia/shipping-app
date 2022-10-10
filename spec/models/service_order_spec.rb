require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  subject(:order) { FactoryBot.build(:service_order) }

  describe '#valid?' do 
    context 'Presence validation is' do 
      it 'false when sender_full_address is empty' do 
        order.sender_full_address = nil 
  
        order.valid? 

        expect(order.errors.include? :sender_full_address).to be_truthy
      end
  
      it 'false when sender_zip_code is empty' do 
        order.sender_zip_code = nil
  
        order.valid? 

        expect(order.errors.include? :sender_zip_code).to be_truthy
      end
  
      it 'false when package_height is empty' do 
        order.package_height = nil 
  
        order.valid? 

        expect(order.errors.include? :package_height).to be_truthy
      end

      it 'false when package_width is empty' do 
        order.package_width = nil 

        order.valid? 

        expect(order.errors.include? :package_width).to be_truthy
      end

      it 'false when package_depth is empty' do 
        order.package_depth = nil 

        order.valid? 

        expect(order.errors.include? :package_depth).to be_truthy
      end

      it 'false when package_weight is empty' do 
        order.package_weight = nil 

        order.valid? 

        expect(order.errors.include? :package_weight).to be_truthy
      end

      it 'false when receiver_name is empty' do 
        order.receiver_name = nil 

        order.valid? 

        expect(order.errors.include? :receiver_name).to be_truthy
      end

      it 'false when receiver_full_address is empty' do 
        order.receiver_full_address = nil 

        order.valid? 

        expect(order.errors.include? :receiver_full_address).to be_truthy
      end

      it 'false when receiver_zip_code is empty' do 
        order.receiver_zip_code = nil 

        order.valid? 

        expect(order.errors.include? :receiver_zip_code).to be_truthy
      end

      it 'false when distance is empty' do 
        order.distance = nil 

        order.valid? 

        expect(order.errors.include? :distance).to be_truthy
      end
    end
  end

  describe '#formatted_dimensions' do 
    context 'Dimesions are prettily formatted' do 
      it 'correctly' do 
        order.package_height = 30
        order.package_width = 20
        order.package_depth = 10 

        expect(order.formatted_dimensions).to eq '30 x 20 x 10'
      end
    end
  end

end
