module Dina
  describe 'ObjectStore' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ObjectStore" do
      os = Dina::ObjectStore.new
      expect(os).to be_a(Dina::ObjectStore)
    end

    it "should create an object of type ObjectStore with a UUID as id" do
      os = Dina::ObjectStore.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStore with default attributes" do
      os = Dina::ObjectStore.new({ id: @id })
      default = {
        "type" => "metadata",
        "id" => @id,
        "publiclyReleasable" => true,
        "xmpRightsOwner" => "Government of Canada",
        "xmpRightsUsageTerms" => "Government of Canada Usage Term",
        "acHashFunction" => "SHA-1",
        "dcRights" => "© Her Majesty The Queen in Right of Canada, as represented by the Minister of Agriculture and Agri-Food | © Sa Majesté la Reine du chef du Canada, représentée par le ministre de l’Agriculture et de l’Agroalimentaire",
        "xmpRightsWebStatement" => "https://open.canada.ca/en/open-government-licence-canada"
      }
      expect(os.attributes).to eq(default)
    end

    it "can have one ac_metadata_creator" do
      os = Dina::ObjectStore.new({ ac_metadata_creator: Dina::Person.new })
      expect(os.ac_metadata_creator).to be_a(Dina::Person)
    end

    it "can have one dc_creator" do
      os = Dina::ObjectStore.new({ dc_creator: Dina::Person.new })
      expect(os.dc_creator).to be_a(Dina::Person)
    end

    it "can have many derivatives" do
      os = Dina::ObjectStore.new({ derivatives: [ Dina::Derivative.new ]})
      expect(os.derivatives.size).to eq(1)
    end

  end
end
