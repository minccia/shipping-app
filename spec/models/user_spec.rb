require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Creating a new user' do 
    let(:user) { User.new(name: 'Paola', email: 'p@email.com', password: '12345678')}

    describe '#valid?' do 
      it 'false when name is empty' do 
        user.name = nil 

        expect(user).to be_invalid
      end

      it 'false when email is empty' do 
        user.email = nil

        expect(user).to be_invalid
      end

      it 'false when password is empty' do 
        user.password = nil 

        expect(user).to be_invalid
      end
    end
  end

end
