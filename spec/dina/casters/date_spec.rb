module Dina
  describe 'DateCaster' do

    before(:each) do
      @default = "2023-05-30"
    end

    it "should validate a string as a date" do
      string = "2023-05-29"
      casted = DateCaster.cast(string, @default)
      expect(casted).to eq(string)
    end

    it "should pass through a Date and cast it as a string" do
      date = Date.parse(@default)
      casted = DateCaster.cast(date, @default)
      expect(casted).to eq(date.to_s)
    end

    it "should throw an error if the date string is not valid" do
      string = "2023-29-05"
      expect { DateCaster.cast(string, @default) }.to raise_error(PropertyValueInvalid, "Invalid date")
    end

  end
end
