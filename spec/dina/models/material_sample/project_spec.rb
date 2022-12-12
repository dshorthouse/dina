module Dina
  describe 'Project' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Project" do
      project = Dina::Project.new
      expect(project).to be_a(Dina::Project)
    end

    it "should create an object of type Project with default attributes" do
      project = Dina::Project.new({ id: @id })
      expect(project.attributes).to eq({"type"=>"project", "id"=>@id})
    end

    it "can have many attachments" do
      project = Dina::Project.new
      expect(project.attachment).to be_nil
    end

    it "should raise an Exception if group is missing" do
      project = Dina::Project.new({ group: nil })
      expect { project.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end