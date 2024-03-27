module Dina
  describe 'StorageUnitType' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type StorageUnitType" do
      su = StorageUnitType.new
      expect(su).to be_a(StorageUnitType)
    end

    it "should create an object of type StorageUnitType with default attributes" do
      su = StorageUnitType.new({ id: @id })
      expect(su.attributes).to eq({"type"=>"storage-unit-type", "id"=>@id})
    end

    it "should raise an Exception if group is missing" do
      su = StorageUnitType.new({ group: nil })
      expect { su.save }.to raise_error(ObjectInvalid)
    end
  end
end
