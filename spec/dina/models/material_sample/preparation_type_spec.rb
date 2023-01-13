module Dina
  describe 'PreparationType' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type PreparationType" do
      pt = PreparationType.new
      expect(pt).to be_a(PreparationType)
    end

    it "should create an object of type PreparationType with a UUID as id" do
      pt = PreparationType.new
      expect(pt.id).to be_a_uuid
    end

    it "can have a multilingual description by sending a Hash" do
      pt = PreparationType.new
      pt.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(pt.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      pt = PreparationType.new({ group: nil })
      expect { pt.save }.to raise_error(ObjectInvalid)
    end

  end
end
