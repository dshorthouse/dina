module Dina
  describe 'Collection' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Collection" do
      collection = Dina::Collection.new
      expect(collection).to be_a(Dina::Collection)
    end

    it "should create an object of type Collection with a UUID as id" do
      collection = Dina::Collection.new
      expect(collection.id).to be_a_uuid
    end

    it "should create an object of type Collection with default attributes" do
      collection = Dina::Collection.new({ id: @id })
      expect(collection.attributes).to eq({"type"=>"collection", "id" => @id, "identifiers" => [] })
    end

    it "can have one institution" do
      collection = Dina::Collection.new({ institution: Dina::Institution.new })
      expect(collection.institution).to be_a(Dina::Institution)
    end

    it "can have one parent_collection" do
      collection = Dina::Collection.new({ parent_collection: Dina::Collection.new })
      expect(collection.parent_collection).to be_a(Dina::Collection)
    end

    it "should raise an Exception if group is missing" do
      collection = Dina::Collection.new({ group: nil })
      expect { collection.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
