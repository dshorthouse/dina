module Dina
  describe 'PcrBatch' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type PcrBatch" do
      pcr = PcrBatch.new
      expect(pcr).to be_a(PcrBatch)
    end

    it "should create an object of type PcrBatch with a UUID as id" do
      pcr = PcrBatch.new
      expect(pcr.id).to be_a_uuid
    end

  end
end
