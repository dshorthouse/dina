
module Dina
  describe 'Determination' do

    before(:each) do
      @det = Determination.new
    end

    it "should create an object of type Determination" do
      expect(@det).to be_a(Determination)
    end

    it "should create an object of type Determination with a default scientificNameDetails" do
      expect(@det.scientificNameDetails).to eq({})
    end

    it "should add a classification" do
      @det.classification = "Animalia|Arthropoda"
      expect(@det.classification).to eq("Animalia|Arthropoda")
    end

    it "should add a classification to scientificNameDetails" do
      @det.classification = "Animalia|Arthropoda"
      expect(@det.scientificNameDetails).to eq({ classificationPath: "Animalia|Arthropoda" })
    end

    it "should add a rank to scientificNameDetails" do
      @det.ranks = "kingdom|phylum"
      expect(@det.scientificNameDetails).to eq({ classificationRanks: "kingdom|phylum" })
    end

    it "should remove classification instance from to_hash" do
      @det.classification = "Animalia|Arthropoda"
      expect(@det.to_hash).to eq({ determiner: [], scientificNameDetails: { classificationPath: "Animalia|Arthropoda" } })
    end

    it "should remove ranks instance from to_hash" do
      @det.ranks = "kingdom|phylum"
      expect(@det.to_hash).to eq({ determiner: [], scientificNameDetails: { classificationRanks: "kingdom|phylum" } })
    end

    it "should use a UUID for a determiner" do
      id = SecureRandom.uuid
      @det.add_determiner(id)
      expect(@det.to_hash).to eq({ determiner: [id], scientificNameDetails: {} })
    end

    it "should raise an Exception if determiner is not a UUID" do
      expect { @det.add_determiner("12345") }.to raise_error(PropertyValueInvalid)
    end

  end
end
