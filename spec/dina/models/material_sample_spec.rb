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

    it "should raise an Exception if group is missing" do
      material_sample = Dina::MaterialSample.new({ group: nil, materialSampleName: "My sample" })
      expect { material_sample.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if materialSampleName is missing" do
      material_sample = Dina::MaterialSample.new({ group: "DINA", materialSampleName: nil })
      expect { material_sample.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
