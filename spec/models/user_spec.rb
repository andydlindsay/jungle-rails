require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before :each do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Stamos',
        :email => 'john@stamos.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
    end

    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'should not be valid without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'should not be valid without a last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'should not be valid without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'should not be valid if the password confirmation does not match password' do
      @user.password_confirmation = 'not_the_same'
      expect(@user).not_to be_valid
    end

    it 'should not accept a user with the same email address' do
      @user.save
      user = User.new(
        :first_name => 'John',
        :last_name => 'Stamos',
        :email => 'john@stamos.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
      user.save
      expect(user.id).to eq nil
    end

    it 'should not accept a user with a password less than 8 characters' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      expect(@user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    before :each do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Stamos',
        :email => 'john@stamos.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
      @user.save
    end

    it 'should log a user in with valid credentials' do
      user = User.authenticate_with_credentials('john@stamos.com', 'password')
      expect(user).to eq(@user)
    end

    it 'should not log user in with invalid credentials' do
      user = User.authenticate_with_credentials('john@stamos.com', 'not_correct')
      expect(user).not_to eq(@user)
    end

    it 'should accept an email address with white space before and/or after' do
      user = User.authenticate_with_credentials('  john@stamos.com  ', 'password')
      expect(user).to eq(@user)
    end

    it 'should accept an email address regardless of case' do
      user = User.authenticate_with_credentials('JOHN@STAMOS.com', 'password')
      expect(user).to eq(@user)
    end

  end

end
