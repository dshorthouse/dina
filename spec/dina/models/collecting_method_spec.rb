module Dina
  describe 'CollectingMethod' do

    it "should create an object of type CollectionMethod" do
      cm = Dina::CollectingMethod.new
      expect(cm).to be_a(Dina::CollectingMethod)
    end

    it "should create an object of type CollectingMethod with default attributes" do
      cm = Dina::CollectingMethod.new({ id: @id })
      expect(cm.attributes).to eq({"type"=>"collection-method", "id"=>@id})
    end

  end
end
