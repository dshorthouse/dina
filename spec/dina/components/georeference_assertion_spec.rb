
module Dina
  describe 'GeoreferenceAssertion' do

    before(:each) do
      @assertion = GeoreferenceAssertion.new
    end

    it "should create an object of type GeoreferenceAssertion" do
      expect(@assertion).to be_a(GeoreferenceAssertion)
    end

    it "should create an object of type GeoreferenceAssertion with default options" do
      id = SecureRandom.uuid_v7
      @assertion.add_georeferencedBy(id: id)
      expect(@assertion.georeferencedBy).to eq([ id ])
    end

    it "should raise an Exception if georeferencedBy is not a UUID" do
      expect { @assertion.add_georeferencedBy(id: "12345") }.to raise_error(PropertyValueInvalid)
    end

  end
end
