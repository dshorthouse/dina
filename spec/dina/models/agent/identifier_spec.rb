module Dina
  describe 'Identifier' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Identifier" do
      id = Identifier.new
      expect(id).to be_a(Identifier)
    end

    it "should create an object of type Identifier with default attributes" do
      id = Identifier.new({ id: @id })
      expect(id.attributes).to eq({"type"=>"identifier", "id"=>@id})
    end

    it "should raise an Exception if namespace is missing" do
      id = Identifier.new({ namespace: nil, value: "Q12345" })
      expect { id.save }.to raise_error(ObjectInvalid, "Dina::Identifier is invalid. namespace is required")
    end

    it "should raise an Exception if value is missing" do
      id = Identifier.new({ namespace: "WIKIDATA", value: nil })
      expect { id.save }.to raise_error(ObjectInvalid, "Dina::Identifier is invalid. value is required")
    end

  end
end
