module Dina
  describe 'ObjectSubtype' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type ObjectSubtype" do
      os = ObjectSubtype.new
      expect(os).to be_a(ObjectSubtype)
    end

    it "should create an object of type ObjectSubtype with a UUID as id" do
      os = ObjectSubtype.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStore with default attributes" do
      os = ObjectSubtype.new({ id: @id })
      expect(os.attributes).to eq({"id"=> @id, "type"=>"object-subtype"})
    end

    it "should raise an Exception if dcType is invalid" do
      os = ObjectSubtype.new({ id: @id, dcType: "NUMBER" })
      expect { os.save }.to raise_error(PropertyValueInvalid)
    end

  end
end
