module Dina
  describe 'Identifier' do

    before(:each) do
      @id = SecureRandom.uuid
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
      expect { id.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if value is missing" do
      id = Identifier.new({ namespace: "WIKIDATA", value: nil })
      expect { id.save }.to raise_error(ObjectInvalid)
    end

  end
end
