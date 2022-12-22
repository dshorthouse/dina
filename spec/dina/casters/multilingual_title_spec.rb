
module Dina
  describe 'MultilingualTitle' do

    it "should create an object of type MultilingualTitle" do
      mt = Dina::MultilingualTitle.new
      expect(mt).to be_a(Dina::MultilingualTitle)
    end

    it "should create an English title" do
      mt = Dina::MultilingualTitle.new
      mt.english_title = "My title"
      expect(mt.to_hash).to eq({ "titles" => [{ lang: "en", title: "My title" }] })
    end

    it "should create a French title" do
      mt = Dina::MultilingualTitle.new
      mt.french_title = "Ma titre"
      expect(mt.to_hash).to eq({ "titles" => [{ lang: "fr", title: "Ma titre" }] })
    end

  end
end
