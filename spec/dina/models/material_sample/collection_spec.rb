module Dina
  describe 'Collection' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Collection" do
      collection = Collection.new
      expect(collection).to be_a(Collection)
    end

    it "should create an object of type Collection with a UUID as id" do
      collection = Collection.new
      expect(collection.id).to be_a_uuid
    end

    it "should create an object of type Collection with default attributes" do
      collection = Collection.new({ id: @id })
      expect(collection.attributes).to eq({"type"=>"collection", "id" => @id, "identifiers" => [] })
    end

    it "should create an object of type Collection with a createdBy attribute" do
      collection = Collection.new({ id: @id, createdBy: "Peter" })
      expect(collection.attributes).to eq({"type"=>"collection", "id" => @id, "identifiers" => [], "createdBy" => "Peter" })
      expect(collection.createdBy).to eq("Peter")
    end

    it "can have one institution" do
      collection = Collection.new({ institution: Institution.new })
      expect(collection.institution).to be_a(Institution)
    end

    it "can have one parentCollection" do
      collection = Collection.new({ parentCollection: Collection.new })
      expect(collection.parentCollection).to be_a(Collection)
    end

    it "can have a multilingual description by sending a Hash" do
      collection = Collection.new
      collection.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(collection.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      collection = Collection.new({ group: nil })
      expect { collection.save }.to raise_error(ObjectInvalid, "Dina::Collection is invalid. group is required")
    end

  end
end
