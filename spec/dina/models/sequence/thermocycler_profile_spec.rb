module Dina
  describe 'ThermocyclerProfile' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ThermocyclerProfile" do
      therm = Dina::ThermocyclerProfile.new
      expect(therm).to be_a(Dina::ThermocyclerProfile)
    end

    it "should create an object of type ThermocyclerProfile with a UUID as id" do
      therm = Dina::ThermocyclerProfile.new
      expect(therm.id).to be_a_uuid
    end

  end
end
