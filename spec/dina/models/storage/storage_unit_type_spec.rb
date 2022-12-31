module Dina
  describe 'StorageUnitType' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type StorageUnitType" do
      su = Dina::StorageUnitType.new
      expect(su).to be_a(Dina::StorageUnitType)
    end

    it "should create an object of type StorageUnitType with default attributes" do
      su = Dina::StorageUnitType.new({ id: @id })
      expect(su.attributes).to eq({"type"=>"storage-unit-type", "id"=>@id})
    end

    it "should raise an Exception if group is missing" do
      su = Dina::StorageUnitType.new({ group: nil })
      expect { su.save }.to raise_error(Dina::ObjectInvalid)
    end
  end
end
