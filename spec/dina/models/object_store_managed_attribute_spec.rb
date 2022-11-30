module Dina
  describe 'ObjectStoreManagedAttribute' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ObjectStoreManagedAttribute" do
      os = Dina::ObjectStoreManagedAttribute.new
      expect(os).to be_a(Dina::ObjectStoreManagedAttribute)
    end

    it "should create an object of type ObjectStoreManagedAttribute with a UUID as id" do
      os = Dina::ObjectStoreManagedAttribute.new
      expect(os.id).to be_a_uuid
    end

    it "should create an object of type ObjectStoreManagedAttribute with default attributes" do
      os = Dina::ObjectStoreManagedAttribute.new({ id: @id })
      expect(os.attributes).to eq({"id"=> @id, "type"=>"managed-attribute"})
    end

  end
end
