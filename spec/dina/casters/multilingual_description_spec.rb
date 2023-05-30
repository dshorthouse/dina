module Dina
  describe 'MultilingualDescription' do

    before(:each) do
      @md = MultilingualDescription.new
    end

    it "should create an object of type MultilingualDescription" do
      expect(@md).to be_a(MultilingualDescription)
    end

    it "should create an English description" do
      @md.set_description({ en: "My description" })
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "en", desc: "My description" }] })
    end

    it "should create a French description" do
      @md.set_description({ fr: "Ma description" })
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "fr", desc: "Ma description" }] })
    end

    it "should create an English & French description" do
      @md.set_description({ en: "My description" })
      @md.set_description({ fr: "Ma description" })
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "en", desc: "My description" }, { lang: "fr", desc: "Ma description" }] })
    end

  end
end
