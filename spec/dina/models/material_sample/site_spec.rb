module Dina
  describe 'Site' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Site" do
      site = Site.new
      expect(site).to be_a(Site)
    end

    it "should create an object of type Site with default attributes" do
      site = Site.new({ id: @id })
      expect(site.attributes).to eq({"type"=>"site", "id"=>@id, "geographicPlaceNameSourceDetail"=>{}})
    end

    it "can have a multilingual description by sending a Hash" do
      site = Site.new
      site.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(site.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      site = Site.new({ group: nil })
      expect { site.save }.to raise_error(ObjectInvalid)
    end

  end
end