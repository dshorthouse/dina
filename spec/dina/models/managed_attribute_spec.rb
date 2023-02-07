module Dina
  describe 'ManagedAttribute' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ManagedAttribute" do
      ma = ManagedAttribute.new
      expect(ma).to be_a(ManagedAttribute)
    end

    it "should create an object of type ManagedAttribute with a UUID as id" do
      ma = ManagedAttribute.new
      expect(ma.id).to be_a_uuid
    end

    it "should create an object of type ManagedAttribute with default attributes" do
      ma = ManagedAttribute.new({ id: @id })
      expect(ma.attributes).to eq({"id"=> @id, "type"=>"managed-attribute"})
    end

    it "can have a multilingual description by sending a Hash" do
      ma = ManagedAttribute.new
      ma.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(ma.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "can have a multilingual description by sending an array of Hashes" do
      ma = ManagedAttribute.new
      ma.multilingualDescription = { descriptions: [{ lang: "en", desc: "My attribute" }, { lang: "fr", desc: "Mon propriété" }] }
      expect(ma.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      ma = ManagedAttribute.new({ group: nil })
      expect { ma.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if name is missing" do
      ma = ManagedAttribute.new({ group: "DINA", name: nil, vocabularyElementType: "STRING", managedAttributeComponent: "ASSEMBLAGE" })
      expect { ma.save }.to raise_error(ObjectInvalid, "Dina::ManagedAttribute is invalid. name is required")
    end

    it "should raise an Exception if vocabularyElementType is missing" do
      ma = ManagedAttribute.new({ group: "DINA", name: "test", vocabularyElementType: nil, managedAttributeComponent: "ASSEMBLAGE" })
      expect { ma.save }.to raise_error(ObjectInvalid, "Dina::ManagedAttribute is invalid. vocabularyElementType is required")
    end

    it "should raise an Exception if managedAttributeComponent is missing" do
      ma = ManagedAttribute.new({ id: @id, group: "cnc", name: "test", vocabularyElementType: "STRING", })
      expect { ma.save }.to raise_error(ObjectInvalid, "Dina::ManagedAttribute is invalid. managedAttributeComponent is required")
    end

    it "should raise an Exception if managedAttributeComponent is invalid" do
      ma = ManagedAttribute.new({ id: @id, group: "cnc", name: "test", vocabularyElementType: "STRING", managedAttributeComponent: "BIBLIO" })
      expect { ma.save }.to raise_error(PropertyValueInvalid)
    end

    it "should raise an Exception if vocabularyElementType is invalid" do
      ma = ManagedAttribute.new({ id: @id, group: "cnc", vocabularyElementType: "NUMBER" })
      expect { ma.save }.to raise_error(PropertyValueInvalid)
    end

  end
end
