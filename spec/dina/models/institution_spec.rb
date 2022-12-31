module Dina
  describe 'Institution' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Institution" do
      int = Dina::Institution.new
      expect(int).to be_a(Dina::Institution)
    end

    it "should create an object of type Institution with default attributes" do
      int = Dina::Institution.new({ id: @id })
      expect(int.attributes).to eq({"type"=>"institution", "id"=>@id})
    end

    it "can have many collections" do
      int = Dina::Institution.new({ collections: [ Dina::Collection.new ]})
      expect(int.collections.size).to eq(1)
    end

  end
end
