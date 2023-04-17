
module Dina
  describe 'Shipment' do

    before(:each) do
      @shipment = Shipment.new
    end

    it "should create an object of type Shipment" do
      expect(@shipment).to be_a(Shipment)
    end

    it "should create an object of type Shipment with default options" do
      address = Address.new({
        receiverName: "Peter Pipetter",
        companyName: "N/A",
        addressLine1: nil,
        addressLine2: nil,
        city: "Ottawa",
        provinceState: "Ontario",
        zipCode: nil,
        country: "Canada"
      })
      @shipment.add_address(address)
      expect(@shipment.address).to eq(address.to_hash)
    end

    it "should raise an Exception if address is not an Address" do
      expect { @shipment.add_address("12345") }.to raise_error(PropertyValueInvalid)
    end

  end
end
