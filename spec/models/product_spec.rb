require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before(:each) do
      @category = Category.new(name: 'category_name')
      @product = Product.new(
          name: "product_name",
          price_cents: 25,
          quantity: 10,
          category: @category
        )
    end

    context "Create an initial example to ensure all four fields will save successfully" do
      it "it is valid with valid attributes" do
        expect(@product).to be_valid
      end
    end

    context "Checks the validations for the Product model" do
      
      it "it is not valid without a name" do
        @product.name = nil
        expect(@product).to_not be_valid # This first expect triggers the validations
        expect(@product.errors.full_messages).to include("Name can't be blank") # This second expect proves the right error was included.
      end

      it "it is not valid without a price" do
        @product.price_cents = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it "it is not valid without a quantity" do
        @product.quantity = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

      it "it is not valid without a category" do
        @product.category = nil
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end

    end















  end
end