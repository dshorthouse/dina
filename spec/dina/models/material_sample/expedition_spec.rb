module Dina
  describe 'Expedition' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Expedition" do
      expedition = Expedition.new
      expect(expedition).to be_a(Expedition)
    end

    it "should create an object of type Expedition with default attributes" do
      expedition = Expedition.new({ id: @id })
      expect(expedition.attributes).to eq({"type"=>"expedition", "id"=>@id})
    end

    it "can have a multilingual description by sending a Hash" do
      expedition = Expedition.new
      expedition.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(expedition.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      expedition = Expedition.new({ group: nil })
      expect { expedition.save }.to raise_error(ObjectInvalid)
    end

  end
end
