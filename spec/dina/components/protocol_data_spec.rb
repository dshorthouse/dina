
module Dina
  describe 'ProtocolData' do

    before(:each) do
      @protocol_data = ProtocolData.new
      @protocol_data.key = "Forward Primer"
      @protocol_data.vocabularyBased = true
    end

    it "should create an object of type ProtocolData" do
      expect(@protocol_data).to be_a(ProtocolData)
    end

    it "should create an object of type ProtocolData with default options" do
      element = ProtocolDataElement.new({
        elementType: "Concentration",
        value: "0.2",
        vocabularyBased: true,
        unit: "uM"
      })
      @protocol_data.add_data_element(element: element)
      expect(@protocol_data.protocolDataElement).to eq([element.to_hash])
    end

    it "should raise an Exception if protocol_data_element is not an Address" do
      expect { @protocol_data.add_data_element(element: "12345") }.to raise_error(PropertyValueInvalid)
    end

  end
end
