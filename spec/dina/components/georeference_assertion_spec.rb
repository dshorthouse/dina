
module Dina
  describe 'GeoreferenceAssertion' do

    before(:each) do
      @assertion = Dina::GeoreferenceAssertion.new
    end

    it "should create an object of type GeoreferenceAssertion" do
      expect(@assertion).to be_a(Dina::GeoreferenceAssertion)
    end

    it "should create an object of type GeoreferenceAssertion with default options" do
      id = SecureRandom.uuid
      @assertion.add_georeferencedBy(id)
      expect(@assertion.georeferencedBy).to eq([ id ])
    end

    it "should raise an Exception if georeferencedBy is not a UUID" do
      expect { @assertion.add_georeferencedBy("12345") }.to raise_error(Dina::PropertyValueInvalid)
    end

  end
end
