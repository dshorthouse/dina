
module Dina
  describe 'MultilingualDescription' do

    it "should create an object of type MultilingualDescription" do
      md = Dina::MultilingualDescription.new
      expect(md).to be_a(Dina::MultilingualDescription)
    end

    it "should create an English description" do
      md = Dina::MultilingualDescription.new
      md.english_description = "My description"
      expect(md.to_hash).to eq({ "descriptions" => [{ lang: "en", desc: "My description" }] })
    end

    it "should create a French description" do
      md = Dina::MultilingualDescription.new
      md.french_description = "Ma description"
      expect(md.to_hash).to eq({ "descriptions" => [{ lang: "fr", desc: "Ma description" }] })
    end

  end
end
