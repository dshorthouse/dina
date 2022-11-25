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
=begin
    it "can have one institution" do
      collection = Dina::Collection.new({ institution: Dina::Institution.new })
      expect(collection.institution).to be_a(Dina::Institution)
    end

    it "can have one parent_collection" do
      collection = Dina::Collection.new({ parent_collection: Dina::Collection.new })
      expect(collection.parent_collection).to be_a(Dina::Collection)
    end
=end
  end
end
