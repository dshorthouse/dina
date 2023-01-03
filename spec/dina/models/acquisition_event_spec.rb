module Dina
  describe 'AquisitionEvent' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type AcquisitionEvent" do
      ae = AcquisitionEvent.new
      expect(ae).to be_a(AcquisitionEvent)
    end

    it "should create an object of type AcquisitionEvent with a UUID as id" do
      ae = AcquisitionEvent.new
      expect(ae.id).to be_a_uuid
    end

    it "should create an object of type AcquisitionEvent with default attributes" do
      ae = AcquisitionEvent.new({ id: @id })
      expect(ae.attributes).to eq({"type"=>"acquisition-event", "id" => @id })
    end

    it "should raise an Exception if group is missing" do
      ae = AcquisitionEvent.new({ group: nil })
      expect { ae.save }.to raise_error(ObjectInvalid)
    end

  end
end
