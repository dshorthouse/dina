module Dina
  describe 'Product' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Product" do
      product = Product.new
      expect(product).to be_a(Product)
    end

    it "should create an object of type Product with a UUID as id" do
      product = Product.new
      expect(product.id).to be_a_uuid
    end

    it "should raise an Exception if group is missing" do
      product = Product.new({ group: nil, name: "name" })
      expect { product.save }.to raise_error(ObjectInvalid, "Dina::Product is invalid. group is required")
    end

    it "should raise an Exception if name is missing" do
      product = Product.new({ group: "ccfc", name: nil })
      expect { product.save }.to raise_error(ObjectInvalid, "Dina::Product is invalid. name is required")
    end

  end
end
