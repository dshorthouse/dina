module Dina
  describe 'CollectingMethod' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type CollectionMethod" do
      cm = CollectingMethod.new
      expect(cm).to be_a(CollectingMethod)
    end

    it "should create an object of type CollectingMethod with default attributes" do
      cm = CollectingMethod.new({ id: @id })
      expect(cm.attributes).to eq({"type"=>"collection-method", "id"=>@id})
    end

    it "should raise an Exception if group is missing" do
      cm = CollectingMethod.new({ group: nil })
      expect { cm.save }.to raise_error(ObjectInvalid)
    end

  end
end
