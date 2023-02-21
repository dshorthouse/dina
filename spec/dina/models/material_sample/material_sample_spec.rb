module Dina
  describe 'MaterialSample' do

    before(:each) do
      @id = SecureRandom.uuid
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

    it "can have one collecting event" do
      material_sample = MaterialSample.new({ collecting_event: CollectingEvent.new })
      expect(material_sample.collecting_event).to be_a(CollectingEvent)
    end

    it "can have one preparation type" do
      material_sample = MaterialSample.new({ preparation_type: PreparationType.new })
      expect(material_sample.preparation_type).to be_a(PreparationType)
    end

    it "can have one preparation method" do
      material_sample = MaterialSample.new({ preparation_method: PreparationMethod.new })
      expect(material_sample.preparation_method).to be_a(PreparationMethod)
    end

    it "can have one parent material sample" do
      material_sample = MaterialSample.new({ parent_material_sample: MaterialSample.new })
      expect(material_sample.parent_material_sample).to be_a(MaterialSample)
    end

    it "can have one preparation protocol" do
      material_sample = MaterialSample.new({ preparation_protocol: Protocol.new })
      expect(material_sample.preparation_protocol).to be_a(Protocol)
    end

    it "can have one acquisition event" do
      material_sample = MaterialSample.new({ acquisition_event: AcquisitionEvent.new })
      expect(material_sample.acquisition_event).to be_a(AcquisitionEvent)
    end

    it "can have one storage unit" do
      material_sample = MaterialSample.new({ storage_unit: StorageUnit.new })
      expect(material_sample.storage_unit).to be_a(StorageUnit)
    end

    it "can have one collection" do
      material_sample = MaterialSample.new({ collection: Collection.new })
      expect(material_sample.collection).to be_a(Collection)
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

    it "can have many prepared by" do
      material_sample = MaterialSample.new({ prepared_by: [ Person.new, Person.new ]})
      expect(material_sample.prepared_by.size).to eq(2)
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
