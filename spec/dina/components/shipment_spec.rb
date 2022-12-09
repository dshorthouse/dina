
module Dina
  describe 'Shipment' do

    before(:each) do
      @shipment = Dina::Shipment.new
    end

    it "should create an object of type Shipment" do
      expect(@shipment).to be_a(Dina::Shipment)
    end

    it "should create an object of type Shipment with default options" do
      address = {
        receiverName: "Peter Pipetter",
        companyName: "N/A",
        addressLine1: nil,
        addressLine2: nil,
        city: "Ottawa",
        provinceState: "Ontario",
        zipCode: nil,
        country: "Canada"
      }
      @shipment.add_address(address)
      expect(@shipment.address).to eq(address)
    end

    it "should raise an Exception if address is not a Hash" do
      expect { @shipment.add_address("12345") }.to raise_error(Dina::PropertyValueInvalid)
    end

  end
end
