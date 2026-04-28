module Dina
  describe 'Derivative' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Derivative" do
      deriv = Derivative.new
      expect(deriv).to be_a(Derivative)
    end

    it "should create an object of type Derivative with a UUID as id" do
      deriv = Derivative.new
      expect(deriv.id).to be_a_uuid
    end

    it "can have one acDerivedFrom" do
      deriv = Derivative.new
      deriv.bucket = "cnc"
      deriv.acDerivedFrom = ObjectStore.new
      expect(deriv.as_json_api["relationships"]).to have_key("acDerivedFrom")
    end

    it "should raise an Exception if bucket is missing" do
      deriv = Derivative.new
      deriv.bucket = nil
      deriv.dcFormat = "image/jpeg"
      deriv.dcType = "IMAGE"
      deriv.fileExtension = ".jpg"
      deriv.fileIdentifier = "123"
      deriv.acDerivedFrom =  ObjectStore.new
      expect { deriv.save }.to raise_error(ObjectInvalid, "Dina::Derivative is invalid. bucket is required")
    end

    it "should raise an Exception if acDerivedFrom is missing" do
      deriv = Derivative.new
      deriv.bucket = "cnc"
      deriv.dcFormat = "image/jpeg"
      deriv.dcType = "IMAGE"
      deriv.fileExtension = ".jpg"
      deriv.fileIdentifier = "123"
      expect { deriv.save }.to raise_error(ObjectInvalid, "Dina::Derivative is invalid. acDerivedFrom relationship is required")
    end

  end
end
