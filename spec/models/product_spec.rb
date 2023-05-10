require 'rails_helper'

RSpec.describe ProductSpec, type: :model do
  describe 'Validations' do

    before(:each) do
      @category = Category.create!(name: "Trees")
      @product = Product.create!(
      name: "Chokecherry Tree",
      description: "A tree which grows great berries for syrup!",
      price: 2000,
      quantity: 4,
      category: @category)
    end

    it 'should have a name' do
      @product.name = "Chokecherry Tree"
      expect(@product).to be_present
    end
    it "should have valid a price" do
      @product.price = 2000 
      expect(@product).to be_present
    end
    it "should have a quantity" do
      @product.quantity = 4
      expect(@product).to be_present
    end
    it "should have a valid a category" do
      @product.category = @category
      expect(@product).to be_present
    end
  end
end
