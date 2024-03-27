module Dina
  describe 'Region' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Region" do
      region = Region.new
      expect(region).to be_a(Region)
    end

    it "should create an object of type Region with a UUID as id" do
      region = Region.new
      expect(region.id).to be_a_uuid
    end

    it "should raise an Exception if group is missing" do
      region = Region.new({ group: nil, symbol: "symbol" })
      expect { region.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if symbol is missing" do
      region = Region.new({ group: "ccfc", symbol: nil })
      expect { region.save }.to raise_error(ObjectInvalid)
    end

  end
end
