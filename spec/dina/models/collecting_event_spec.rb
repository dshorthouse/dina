module Dina
  describe 'CollectingEvent' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type CollectingEvent" do
      ce = Dina::CollectingEvent.new
      expect(ce).to be_a(Dina::CollectingEvent)
    end

    it "should create an object of type CollectingEvent with a UUID as id" do
      ce = Dina::CollectingEvent.new
      expect(ce.id).to be_a_uuid
    end

    it "should create an object of type CollectingEvent with default attributes" do
      ce = Dina::CollectingEvent.new({ id: @id })
      default = {
        "id"=>@id,
        "dwcOtherRecordNumbers"=>[],
        "dwcVerbatimCoordinateSystem"=>"decimal degrees",
        "dwcVerbatimSRS"=>"WGS84 (EPSG:4326)",
        "extensionValues"=>[],
        "geoReferenceAssertions"=>[],
        "geographicPlaceNameSourceDetail"=>[{"sourceID"=>nil, "sourceIdType"=>nil, "sourceURL"=>nil}],
        "managedAttributes"=>[],
        "tags"=>[],
        "type"=>"collecting-event"
      }
      expect(ce.attributes).to eq(default)
    end

    it "can have many collectors" do
      ce = Dina::CollectingEvent.new({ collectors: [ Dina::Person.new, Dina::Person.new]})
      expect(ce.collectors.size).to eq(2)
    end

    it "can have many attachments" do
      ce = Dina::CollectingEvent.new({ attachment: [ Dina::Attachment.new ]})
      expect(ce.attachment.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      ce = Dina::CollectingEvent.new({ group: nil })
      expect { ce.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
