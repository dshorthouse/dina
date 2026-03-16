module Dina
  describe 'Geospatial' do

    before(:each) do
      @geo = Geospatial.new
    end

    it "should create an object of type Geospatial" do
      expect(@geo).to be_a(Geospatial)
    end

    it "should create an object of type Polygon" do
      @geo.type = "Polygon"
      expect(@geo.to_hash).to eq({ "type" => "Polygon", "coordinates" => [] })
    end

  end
end