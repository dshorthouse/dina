module Dina
  describe 'File' do

    it "should create an object of type File" do
      file = File.new
      expect(file).to be_a(File)
    end

    it "should instantiate an object of type File with a UUID as id" do
      file = File.new
      expect(file.id).to be_a_uuid
    end

    it "should throw an error if group is missing" do
      file = File.new
      file.group = nil
      file.filePath = mock_token_path
      file.fileName = "test"
      file.dcFormat = "application/x-yaml"
      expect { file.save }.to raise_error(ObjectInvalid)
    end

    it "should throw an error if filePath is missing" do
      file = File.new
      file.group = "CNC"
      file.fileName = "test"
      file.dcFormat = "application/x-yaml"
      expect { file.save }.to raise_error(ObjectInvalid)
    end

    it "should throw an error if group is missing using create method" do
      file = {
        group: nil,
        filePath: ""
      }
      expect { File.create(file) }.to raise_error(ObjectInvalid)
    end

  end
end
