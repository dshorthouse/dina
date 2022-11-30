module Dina
  describe 'ObjectSubtype' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ObjectSubtype" do
      os = Dina::ObjectSubtype.new
      expect(os).to be_a(Dina::ObjectSubtype)
    end

    it "should create an object of type ObjectSubtype with a UUID as id" do
      os = Dina::ObjectSubtype.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStore with default attributes" do
      os = Dina::ObjectSubtype.new({ id: @id })
      expect(os.attributes).to eq({"id"=> @id, "type"=>"object-subtype"})
    end

  end
end
