
module Dina
  describe 'MultilingualDescription' do

    before(:each) do
      @md = Dina::MultilingualDescription.new
    end

    it "should create an object of type MultilingualDescription" do
      expect(@md).to be_a(Dina::MultilingualDescription)
    end

    it "should create an English description" do
      @md.english_description = "My description"
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "en", desc: "My description" }] })
    end

    it "should create a French description" do
      @md.french_description = "Ma description"
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "fr", desc: "Ma description" }] })
    end

    it "should create an English & French description" do
      @md.english_description = "My description"
      @md.french_description = "Ma description"
      expect(@md.to_hash).to eq({ "descriptions" => [{ lang: "en", desc: "My description" }, { lang: "fr", desc: "Ma description" }] })
    end

  end
end
