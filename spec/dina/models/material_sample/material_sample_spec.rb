module Dina
  describe 'MaterialSample' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type MaterialSample" do
      material_sample = MaterialSample.new
      expect(material_sample).to be_a(MaterialSample)
    end

    it "should create an object of type MaterialSample with default attributes" do
      material_sample = MaterialSample.new({ id: @id })
      default = {
        "type" => "material-sample",
        "id" => @id,
        "associations" => [],
        "tags" => [],
        "publiclyReleasable" => true,
        "hostOrganism" => {
          "name" => nil,
          "remarks" => nil
        }
      }
      expect(material_sample.attributes).to eq(default)
    end

    it "can have one collection" do
      material_sample = MaterialSample.new({ collection: Collection.new })
      expect(material_sample.collection).to be_a(Collection)
    end

    it "can have one collectingEvent" do
      material_sample = MaterialSample.new({ collectingEvent: CollectingEvent.new })
      expect(material_sample.collectingEvent).to be_a(CollectingEvent)
    end

    it "can have one preparationType" do
      material_sample = MaterialSample.new({ preparationType: PreparationType.new })
      expect(material_sample.preparationType).to be_a(PreparationType)
    end

    it "can have one preparationMethod" do
      material_sample = MaterialSample.new({ preparationMethod: PreparationMethod.new })
      expect(material_sample.preparationMethod).to be_a(PreparationMethod)
    end

    it "can have one parentMaterialSample" do
      material_sample = MaterialSample.new({ parentMaterialSample: MaterialSample.new })
      expect(material_sample.parentMaterialSample).to be_a(MaterialSample)
    end

    it "can have one preparationProtocol" do
      material_sample = MaterialSample.new({ preparationProtocol: Protocol.new })
      expect(material_sample.preparationProtocol).to be_a(Protocol)
    end

    it "can have one storageUnit" do
      material_sample = MaterialSample.new({ storageUnit: StorageUnit.new })
      expect(material_sample.storageUnit).to be_a(StorageUnit)
    end

    it "can have many attachments" do
      material_sample = MaterialSample.new({ attachment: [ Attachment.new ]})
      expect(material_sample.attachment.size).to eq(1)
    end

    it "can have many projects" do
      material_sample = MaterialSample.new({ projects: [ Project.new ]})
      expect(material_sample.projects.size).to eq(1)
    end

    it "can have many assemblages" do
      material_sample = MaterialSample.new({ assemblages: [ Assemblage.new ]})
      expect(material_sample.assemblages.size).to eq(1)
    end

    it "can have many organisms" do
      material_sample = MaterialSample.new({ organism: [ Organism.new ]})
      expect(material_sample.organism.size).to eq(1)
    end

    it "can have many preparedBy" do
      material_sample = MaterialSample.new({ preparedBy: [ Person.new, Person.new ]})
      expect(material_sample.preparedBy.size).to eq(2)
    end

    it "can have a preparationDate in the form of a date string" do
      material_sample = MaterialSample.new({ group: "DINA", materialSampleName: "DINA", materialSampleType: "WHOLE_ORGANISM"})
      material_sample.preparationDate = "2022-01-01"
      expect(material_sample).to be_a(MaterialSample)
    end

    it "can have a preparationDate in the form of a date object" do
      material_sample = MaterialSample.new({ group: "DINA", materialSampleName: "DINA", materialSampleType: "WHOLE_ORGANISM"})
      material_sample.preparationDate = Date.parse("2022-01-01")
      expect(material_sample).to be_a(MaterialSample)
    end

    it "should raise an Exception if preparationDate is a malformed string" do
      material_sample = MaterialSample.new({ group: "DINA", materialSampleName: "DINA", materialSampleType: "WHOLE_ORGANISM"})
      expect { material_sample.preparationDate = "2022" }.to raise_error(PropertyValueInvalid)
    end

    it "should raise an Exception if group is missing" do
      material_sample = MaterialSample.new({ group: nil, materialSampleName: "My sample", materialSampleType: "WHOLE_ORGANISM" })
      expect { material_sample.save }.to raise_error(ObjectInvalid, "Dina::MaterialSample is invalid. group is required")
    end

    it "should raise an Exception if materialSampleName is missing" do
      material_sample = MaterialSample.new({ group: "DINA", materialSampleName: nil, materialSampleType: "WHOLE_ORGANISM" })
      expect { material_sample.save }.to raise_error(ObjectInvalid, "Dina::MaterialSample is invalid. materialSampleName is required")
    end

    it "should raise an Exception if materialSampleType is missing" do
      material_sample = MaterialSample.new({ id: @id, group: "DINA", materialSampleName: "CNC123", materialSampleType: nil })
      expect { material_sample.save }.to raise_error(ObjectInvalid, "Dina::MaterialSample is invalid. materialSampleType is required")
    end

    it "should raise an Exception if materialSampleType is invalid" do
      material_sample = MaterialSample.new({ id: @id, group: "DINA", materialSampleName: "CNC123", materialSampleType: "NUMBER" })
      expect { material_sample.save }.to raise_error(PropertyValueInvalid, "Dina::MaterialSample is invalid. Accepted value for materialSampleType is one of WHOLE_ORGANISM, CULTURE_STRAIN, ORGANISM_PART, MIXED_ORGANISMS, MOLECULAR_SAMPLE")
    end

  end
end
