module Dina
  describe 'PreparationMethod' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type PreparationMethod" do
      pm = PreparationMethod.new
      expect(pm).to be_a(PreparationMethod)
    end

    it "should create an object of type PreparationMethod with a UUID as id" do
      pm = PreparationMethod.new
      expect(pm.id).to be_a_uuid
    end

    it "can have a multilingual description by sending a Hash" do
      pm = PreparationMethod.new
      pm.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(pm.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      pm = PreparationMethod.new({ group: nil })
      expect { pm.save }.to raise_error(ObjectInvalid)
    end

  end
end
