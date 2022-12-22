module Dina
  describe 'File' do

    it "should create an object of type File" do
      file = Dina::File.new
      expect(file).to be_a(Dina::File)
    end

    it "should instantiate an object of type File with a UUID as id" do
      file = Dina::File.new
      expect(file.id).to be_a_uuid
    end

    it "should set the verify_ssl" do
      Dina::BaseModel.connection_options[:ssl] = { verify: false }
      options = { ssl: { verify: false }}
      expect(Dina::File.connection_options).to eq(options)
      expect(Dina::File.verify_ssl).to eq(false)
    end

    it "should throw an error if id is not a UUID" do
      file = Dina::File.new
      file.id = "missing"
      file.group = "CNC"
      file.file_path = ""
      expect { file.save }.to raise_error("Dina::File is invalid. id is not a UUID.")
    end

    it "should throw an error if group is missing" do
      file = Dina::File.new
      file.group = nil
      file.file_path = ""
      expect { file.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should throw an error if file_path is missing" do
      file = Dina::File.new
      file.group = "CNC"
      file.file_path = nil
      expect { file.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should throw an error if group is missing using create method" do
      file = {
        group: nil,
        file_path: ""
      }
      expect { Dina::File.create(file) }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
