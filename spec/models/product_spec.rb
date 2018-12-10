require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before :all do
      @category = Category.new(
        :name => 'New Category'
      )
    end

    before :each do
      @product = Product.new(
        :name => 'New Product',
        :price_cents => 1999,
        :quantity => 20,
        :category => @category
      )
    end

    it 'is valid with valid attributes' do
      expect(@product).to be_valid
    end

    it 'should not be valid without a price' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq('Price cents is not a number')
    end

    it 'should not be valid without a name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq('Name can\'t be blank')
    end

    it 'should not be valid without a category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq('Category can\'t be blank')
    end

    it 'should not be valid without a quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq('Quantity can\'t be blank')
    end

  end

end
