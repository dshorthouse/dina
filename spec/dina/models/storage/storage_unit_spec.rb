module Dina
  describe 'StorageUnit' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type StorageUnit" do
      su = StorageUnit.new
      expect(su).to be_a(StorageUnit)
    end

    it "should create an object of type StorageUnit with default attributes" do
      su = StorageUnit.new({ id: @id })
      expect(su.attributes).to eq({"type"=>"storage-unit", "id"=>@id})
    end

    it "should raise an Exception if group is missing" do
      su = StorageUnit.new({ group: nil })
      expect { su.save }.to raise_error(ObjectInvalid)
    end
  end
end
