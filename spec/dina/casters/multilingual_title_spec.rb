
module Dina
  describe 'MultilingualTitle' do

    before(:each) do
      @mt = Dina::MultilingualTitle.new
    end

    it "should create an object of type MultilingualTitle" do
      expect(@mt).to be_a(Dina::MultilingualTitle)
    end

    it "should create an English title" do
      @mt.english_title = "My title"
      expect(@mt.to_hash).to eq({ "titles" => [{ lang: "en", title: "My title" }] })
    end

    it "should create a French title" do
      @mt.french_title = "Ma titre"
      expect(@mt.to_hash).to eq({ "titles" => [{ lang: "fr", title: "Ma titre" }] })
    end

    it "should create an English & French title" do
      @mt.english_title = "My title"
      @mt.french_title = "Ma titre"
      expect(@mt.to_hash).to eq({ "titles" => [{ lang: "en", title: "My title" }, { lang: "fr", title: "Ma titre" }] })
    end

  end
end
