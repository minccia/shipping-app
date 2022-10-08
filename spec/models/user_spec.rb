require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Creating a new user' do 
    subject(:user) { FactoryBot.build(:user) }

    describe '#valid?' do 
      it 'false when name is empty' do 
        user.name = nil 

        user.valid? 
        expect(user.errors.include? :name).to be_truthy
      end

      it 'false when email is empty' do 
        user.email = nil

        user.valid? 

        expect(user.errors.include? :email).to be_truthy
      end

      it 'false when password is empty' do 
        user.password = nil 

        user.valid? 

        expect(user.errors.include? :password).to be_truthy
      end

      it 'false when email doesnt have @sistemadefrete.com.br domain' do 
        user.email = 'paolitas@emailbemdiferente.com'

        user.valid?

        expect(user.errors.include? :email).to be_truthy
      end

    end
  end

end
