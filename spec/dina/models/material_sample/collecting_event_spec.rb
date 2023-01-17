module Dina
  describe 'CollectingEvent' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type CollectingEvent" do
      ce = CollectingEvent.new
      expect(ce).to be_a(CollectingEvent)
    end

    it "should create an object of type CollectingEvent with a UUID as id" do
      ce = CollectingEvent.new
      expect(ce.id).to be_a_uuid
    end

    it "should create an object of type CollectingEvent with default attributes" do
      ce = CollectingEvent.new({ id: @id })
      default = {
        "id"=>@id,
        "dwcOtherRecordNumbers"=>[],
        "dwcVerbatimCoordinateSystem"=>"decimal degrees",
        "dwcVerbatimSRS"=>"WGS84 (EPSG:4326)",
        "extensionValues"=>[],
        "geoReferenceAssertions"=>[],
        "geographicPlaceNameSourceDetail"=>{},
        "managedAttributes"=>[],
        "tags"=>[],
        "type"=>"collecting-event",
        "publiclyReleasable" => true
      }
      expect(ce.attributes).to eq(default)
    end

    it "can have many collectors" do
      ce = CollectingEvent.new({ collectors: [ Person.new, Person.new]})
      expect(ce.collectors.size).to eq(2)
    end

    it "can have many attachments" do
      ce = CollectingEvent.new({ attachment: [ Attachment.new ]})
      expect(ce.attachment.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      ce = CollectingEvent.new({ group: nil })
      expect { ce.save }.to raise_error(ObjectInvalid, "Dina::CollectingEvent is invalid. group is required")
    end

  end
end
