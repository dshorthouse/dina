module Dina
  describe 'Institution' do

    before(:all) do
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
      int = Dina::Institution.new
      expect(int.collections).to be_nil
    end

  end
end
