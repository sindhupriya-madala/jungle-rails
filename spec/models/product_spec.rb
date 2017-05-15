require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new(name: "Test Category")
    @product = @category.products.new(
      name: "Test Product",
      description: "test product description",
      quantity: 1,
      price: 65.45
    )
  end

  describe 'Validations' do
    it "all validations should pass" do
      @product.valid?
      expect(@product.errors.full_messages.length).to eql(0)
    end

    it "should return error with Name can't be nil" do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should return error with Price can't be Blank" do
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should return error with quantity can't be Blank" do
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should return error with Price can't be Blank" do
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
