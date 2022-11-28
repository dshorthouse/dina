module Dina
  describe 'AquisitionEvent' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type AcquisitionEvent" do
      ae = Dina::AcquisitionEvent.new
      expect(ae).to be_a(Dina::AcquisitionEvent)
    end

    it "should create an object of type AcquisitionEvent with a UUID as id" do
      ae = Dina::AcquisitionEvent.new
      expect(ae.id).to be_a_uuid
    end

    it "should create an object of type AcquisitionEvent with default attributes" do
      ae = Dina::AcquisitionEvent.new({ id: @id })
      expect(ae.attributes).to eq({"type"=>"acquisition-event", "id" => @id })
    end

    it "should raise an Exception if group is missing" do
      protocol = Dina::Protocol.new({ group: nil })
      expect { protocol.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
