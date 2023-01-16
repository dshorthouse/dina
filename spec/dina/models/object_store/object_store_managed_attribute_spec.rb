module Dina
  describe 'ObjectStoreManagedAttribute' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ObjectStoreManagedAttribute" do
      os = ObjectStoreManagedAttribute.new
      expect(os).to be_a(ObjectStoreManagedAttribute)
    end

    it "should create an object of type ObjectStoreManagedAttribute with a UUID as id" do
      os = ObjectStoreManagedAttribute.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStoreManagedAttribute with default attributes" do
      os = ObjectStoreManagedAttribute.new({ id: @id })
      expect(os.attributes).to eq({"id"=> @id, "type"=>"managed-attribute"})
    end

    it "can have a multilingual description by sending a Hash" do
      os = ObjectStoreManagedAttribute.new
      os.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(os.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if vocabularyElementType is invalid" do
      os = ObjectStoreManagedAttribute.new({ id: @id, vocabularyElementType: "NUMBER" })
      expect { os.save }.to raise_error(PropertyValueInvalid)
    end

  end
end
