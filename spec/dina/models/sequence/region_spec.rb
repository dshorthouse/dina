module Dina
  describe 'Region' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Region" do
      region = Dina::Region.new
      expect(region).to be_a(Dina::Region)
    end

    it "should create an object of type Region with a UUID as id" do
      region = Dina::Region.new
      expect(region.id).to be_a_uuid
    end

  end
end
