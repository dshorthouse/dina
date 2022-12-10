module Dina
  describe 'PcrPrimer' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type PcrPrimer" do
      pcr = Dina::PcrPrimer.new
      expect(pcr).to be_a(Dina::PcrPrimer)
    end

    it "should create an object of type PcrPrimer with a UUID as id" do
      pcr = Dina::PcrPrimer.new
      expect(pcr.id).to be_a_uuid
    end

  end
end
