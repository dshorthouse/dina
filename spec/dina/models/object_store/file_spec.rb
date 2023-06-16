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

    it "should set the verify_ssl" do
      BaseModel.connection_options[:ssl] = { verify: false }
      options = { ssl: { verify: false }}
      expect(File.connection_options).to eq(options)
      expect(File.verify_ssl).to eq(false)
    end

    it "should throw an error if id is not a UUID" do
      file = File.new
      file.id = "missing"
      file.group = "CNC"
      file.file_path = ""
      expect { file.save }.to raise_error("Dina::File is invalid. id is not a UUID.")
    end

    it "should throw an error if group is missing" do
      file = File.new
      file.group = nil
      file.file_path = ""
      expect { file.save }.to raise_error(ObjectInvalid)
    end

    it "should throw an error if file_path is missing" do
      file = File.new
      file.group = "CNC"
      file.file_path = nil
      expect { file.save }.to raise_error(ObjectInvalid)
    end

    it "should throw an error if group is missing using create method" do
      file = {
        group: nil,
        file_path: ""
      }
      expect { File.create(file) }.to raise_error(ObjectInvalid)
    end

    it "should have a file_path and return the file_path" do
      file = File.new file_path: mock_empty_token_path
      expect(file.file_path).to eq(mock_empty_token_path)
    end

    it "should have an original_filename method and return the filename" do
      filename = "My file.txt"
      file = File.new file_path: mock_empty_token_path, filename: filename
      expect(file.file.original_filename).to eq(filename)
    end

  end
end
