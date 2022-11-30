module Dina
  describe 'MaterialSample' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type MaterialSample" do
      material_sample = Dina::MaterialSample.new
      expect(material_sample).to be_a(Dina::MaterialSample)
    end

    it "should create an object of type MaterialSample with default attributes" do
      material_sample = Dina::MaterialSample.new({ id: @id })
      default = {
        "type" => "material-sample",
        "id" => @id,
        "associations" => [],
        "tags" => [],
        "hostOrganism" => {
          "name" => nil,
          "remarks" => nil
        }
      }
      expect(material_sample.attributes).to eq(default)
    end

    it "can have one collection" do
      material_sample = Dina::MaterialSample.new({ collection: Dina::Collection.new })
      expect(material_sample.collection).to be_a(Dina::Collection)
    end

    it "can have one collecting event" do
      material_sample = Dina::MaterialSample.new({ collecting_event: Dina::CollectingEvent.new })
      expect(material_sample.collecting_event).to be_a(Dina::CollectingEvent)
    end

    it "can have one preparation type" do
      material_sample = Dina::MaterialSample.new({ preparation_type: Dina::PreparationType.new })
      expect(material_sample.preparation_type).to be_a(Dina::PreparationType)
    end

    it "can have one preparation method" do
      material_sample = Dina::MaterialSample.new({ preparation_method: Dina::PreparationMethod.new })
      expect(material_sample.preparation_method).to be_a(Dina::PreparationMethod)
    end

    it "can have one parent material sample" do
      material_sample = Dina::MaterialSample.new({ parent_material_sample: Dina::MaterialSample.new })
      expect(material_sample.parent_material_sample).to be_a(Dina::MaterialSample)
    end

    it "can have one preparation protocol" do
      material_sample = Dina::MaterialSample.new({ preparation_protocol: Dina::Protocol.new })
      expect(material_sample.preparation_protocol).to be_a(Dina::Protocol)
    end

    it "can have one acquisition event" do
      material_sample = Dina::MaterialSample.new({ acquisition_event: Dina::AcquisitionEvent.new })
      expect(material_sample.acquisition_event).to be_a(Dina::AcquisitionEvent)
    end

    it "can have one storage unit" do
      material_sample = Dina::MaterialSample.new({ storage_unit: Dina::StorageUnit.new })
      expect(material_sample.storage_unit).to be_a(Dina::StorageUnit)
    end

    it "can have one collection" do
      material_sample = Dina::MaterialSample.new({ collection: Dina::Collection.new })
      expect(material_sample.collection).to be_a(Dina::Collection)
    end

    it "can have many attachments" do
      material_sample = Dina::MaterialSample.new({ attachment: [ Dina::Attachment.new ]})
      expect(material_sample.attachment.size).to eq(1)
    end

    it "can have many projects" do
      material_sample = Dina::MaterialSample.new({ projects: [ Dina::Project.new ]})
      expect(material_sample.projects.size).to eq(1)
    end

    it "can have many assemblages" do
      material_sample = Dina::MaterialSample.new({ assemblages: [ Dina::Assemblage.new ]})
      expect(material_sample.assemblages.size).to eq(1)
    end

    it "can have many organisms" do
      material_sample = Dina::MaterialSample.new({ organism: [ Dina::Organism.new ]})
      expect(material_sample.organism.size).to eq(1)
    end

    it "can have many prepared by" do
      material_sample = Dina::MaterialSample.new({ prepared_by: [ Dina::Person.new ]})
      expect(material_sample.prepared_by.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      material_sample = Dina::MaterialSample.new({ group: nil, materialSampleName: "My sample" })
      expect { material_sample.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if materialSampleName is missing" do
      material_sample = Dina::MaterialSample.new({ group: "DINA", materialSampleName: nil, materialSampleType: "WHOLE_ORGANISM" })
      expect { material_sample.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if materialSampleType is missing" do
      material_sample = Dina::MaterialSample.new({ id: @id, group: "DINA", materialSampleName: "CNC123", materialSampleType: nil })
      expect { material_sample.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if materialSampleType is invalid" do
      material_sample = Dina::MaterialSample.new({ id: @id, group: "DINA", materialSampleName: "CNC123", materialSampleType: "NUMBER" })
      expect { material_sample.save }.to raise_error(Dina::PropertyValueInvalid)
    end

  end
end
