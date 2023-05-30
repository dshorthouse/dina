module Dina
  describe 'HashCaster' do

    before(:each) do
      @default = { key: "value" }
    end

    it "should pass through a hash" do
      hash = { one: "two" }
      casted = HashCaster.cast(hash, @default)
      expect(casted).to eq(hash)
    end

    it "should cast an object" do
      struct = Struct.new(:one)
      new_struct = struct.new("two")
      casted = HashCaster.cast(new_struct, @default)
      expect(casted).to eq({ one: "two"})
    end

  end
end
