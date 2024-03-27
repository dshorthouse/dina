module Dina
  describe 'PcrPrimer' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type PcrPrimer" do
      pcr = PcrPrimer.new
      expect(pcr).to be_a(PcrPrimer)
    end

    it "should create an object of type PcrPrimer with a UUID as id" do
      pcr = PcrPrimer.new
      expect(pcr.id).to be_a_uuid
    end

  end
end
