module Dina
  describe 'Region' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Region" do
      region = Region.new
      expect(region).to be_a(Region)
    end

    it "should create an object of type Region with a UUID as id" do
      region = Region.new
      expect(region.id).to be_a_uuid
    end

  end
end
