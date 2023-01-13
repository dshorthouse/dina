module Dina
  describe 'Project' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Project" do
      project = Project.new
      expect(project).to be_a(Project)
    end

    it "should create an object of type Project with default attributes" do
      project = Project.new({ id: @id })
      expect(project.attributes).to eq({"type"=>"project", "id"=>@id})
    end

    it "can have many attachments" do
      project = Project.new
      expect(project.attachment).to be_nil
    end

    it "can have a multilingual description by sending a Hash" do
      project = Project.new
      project.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(project.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      project = Project.new({ group: nil })
      expect { project.save }.to raise_error(ObjectInvalid)
    end

  end
end
