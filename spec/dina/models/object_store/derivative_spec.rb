module Dina
  describe 'Derivative' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Derivative" do
      deriv = Derivative.new
      expect(deriv).to be_a(Derivative)
    end

    it "should create an object of type Derivative with a UUID as id" do
      deriv = Derivative.new
      expect(deriv.id).to be_a_uuid
    end

    it "can have one acDerivedFrom" do
      deriv = Derivative.new({ ac_derived_from:  ObjectStore.new })
      expect(deriv.ac_derived_from).to be_a(ObjectStore)
    end

  end
end
