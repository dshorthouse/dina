module Dina
  describe 'Identifier' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Identifier" do
      id = Dina::Identifier.new
      expect(id).to be_a(Dina::Identifier)
    end

    it "should create an object of type Identifier with default attributes" do
      id = Dina::Identifier.new({ id: @id })
      expect(id.attributes).to eq({"type"=>"identifier", "id"=>@id})
    end

    it "should raise an Exception if namespace is missing" do
      id = Dina::Identifier.new({ namespace: nil, value: "Q12345" })
      expect { id.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if value is missing" do
      id = Dina::Identifier.new({ namespace: "WIKIDATA", value: nil })
      expect { id.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
