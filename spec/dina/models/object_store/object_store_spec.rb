module Dina
  describe 'ObjectStore' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ObjectStore" do
      os = ObjectStore.new
      expect(os).to be_a(ObjectStore)
    end

    it "should create an object of type ObjectStore with a UUID as id" do
      os = ObjectStore.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStore with default attributes" do
      os = ObjectStore.new({ id: @id })
      default = {
        "type" => "metadata",
        "id" => @id,
        "publiclyReleasable" => true,
        "xmpRightsOwner" => "Government of Canada",
        "xmpRightsUsageTerms" => "Government of Canada Usage Term",
        "acHashFunction" => "SHA-1",
        "dcFormat" => "image/jpeg",
        "dcRights" => "© His Majesty The King in Right of Canada, as represented by the Minister of Agriculture and Agri-Food | © Sa Majesté le Roi du chef du Canada, représentée par le ministre de l’Agriculture et de l’Agroalimentaire",
        "xmpRightsWebStatement" => "https://open.canada.ca/en/open-government-licence-canada"
      }
      expect(os.attributes).to eq(default)
    end

    it "can have one ac_metadata_creator" do
      os = ObjectStore.new({ ac_metadata_creator: Person.new })
      expect(os.ac_metadata_creator).to be_a(Person)
    end

    it "can have one dc_creator" do
      os = ObjectStore.new({ dc_creator: Person.new })
      expect(os.dc_creator).to be_a(Person)
    end

    it "can have many derivatives" do
      os = ObjectStore.new({ derivatives: [ Derivative.new ]})
      expect(os.derivatives.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      os = ObjectStore.new({ group: nil, dcFormat: "image/jpeg", dcType: "IMAGE", xmpRightsUsageTerms: "None", dcRights: "None" })
      expect { os.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if dcFormat is missing" do
      os = ObjectStore.new({ group: "CNC", dcFormat: nil, dcType: "IMAGE", xmpRightsUsageTerms: "None", dcRights: "None" })
      expect { os.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if dcType is missing" do
      os = ObjectStore.new({ group: "CNC", dcFormat: "image/jpeg", dcType: nil, xmpRightsUsageTerms: "None", dcRights: "None" })
      expect { os.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if xmpRightsUsageTerms is missing" do
      os = ObjectStore.new({ group: "CNC", dcFormat: "image/jpeg", dcType: "IMAGE", xmpRightsUsageTerms: nil, dcRights: "None" })
      expect { os.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if dcRights is missing" do
      os = ObjectStore.new({ group: "CNC", dcFormat: "image/jpeg", dcType: "IMAGE", xmpRightsUsageTerms: "None", dcRights: nil })
      expect { os.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if dcType is invalid" do
      os = ObjectStore.new({ id: @id, group: "cnc", dcFormat: "image/jpeg", dcType: "NUMBER", xmpRightsUsageTerms: "None", dcRights: "None" })
      expect { os.save }.to raise_error(PropertyValueInvalid)
    end

  end
end
