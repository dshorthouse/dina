module Dina
  describe 'StorageUnit' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type StorageUnit" do
      su = Dina::StorageUnit.new
      expect(su).to be_a(Dina::StorageUnit)
    end

    it "should create an object of type StorageUnit with default attributes" do
      su = Dina::StorageUnit.new({ id: @id })
      expect(su.attributes).to eq({"type"=>"storage-unit", "id"=>@id})
    end

    it "should raise an Exception if group is missing" do
      su = Dina::StorageUnit.new({ group: nil })
      expect { su.save }.to raise_error(Dina::ObjectInvalid)
    end
  end
end
