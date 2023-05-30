module Dina
  describe 'ArrayCaster' do

    before(:each) do
      @default = "default"
    end

    it "should cast a string to an array" do
      string = "something"
      casted = ArrayCaster.cast(string, @default)
      expect(casted).to eq([string])
    end

    it "should pass through an array and not cast it" do
      array = ["something"]
      casted = ArrayCaster.cast(array, @default)
      expect(casted).to eq(array)
    end

    it "should use the default if the item is neither a string or an array" do
      obj = { item: "something" }
      casted = ArrayCaster.cast(obj, @default)
      expect(casted).to eq(@default)
    end

  end
end
