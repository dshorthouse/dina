module Dina
  describe 'Institution' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Institution" do
      int = Institution.new
      expect(int).to be_a(Institution)
    end

    it "should create an object of type Institution with default attributes" do
      int = Institution.new({ id: @id })
      expect(int.attributes).to eq({"type"=>"institution", "id"=>@id})
    end

    it "can have many collections" do
      int = Institution.new({ collections: [ Collection.new ]})
      expect(int.collections.size).to eq(1)
    end

  end
end
