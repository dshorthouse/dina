module Dina
  describe 'ThermocyclerProfile' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type ThermocyclerProfile" do
      therm = ThermocyclerProfile.new
      expect(therm).to be_a(ThermocyclerProfile)
    end

    it "should create an object of type ThermocyclerProfile with a UUID as id" do
      therm = ThermocyclerProfile.new
      expect(therm.id).to be_a_uuid
    end

  end
end
