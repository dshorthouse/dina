module Dina
  describe 'ManagedAttribute' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ManagedAttribute" do
      ma = Dina::ManagedAttribute.new
      expect(ma).to be_a(Dina::ManagedAttribute)
    end

    it "should create an object of type ManagedAttribute with a UUID as id" do
      ma = Dina::ManagedAttribute.new
      expect(ma.id).to be_a_uuid
    end

    it "should create an object of type ManagedAttribute with default attributes" do
      ma = Dina::ManagedAttribute.new({ id: @id })
      expect(ma.attributes).to eq({"id"=> @id, "type"=>"managed-attribute"})
    end

    it "should raise an Exception if group is missing" do
      ma = Dina::ManagedAttribute.new({ group: nil })
      expect { ma.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if managedAttributeComponent is invalid" do
      ma = Dina::ManagedAttribute.new({ id: @id, group: "cnc", managedAttributeComponent: "BIBLIO" })
      expect { ma.save }.to raise_error(Dina::PropertyValueInvalid)
    end

    it "should raise an Exception if managedAttributeType is invalid" do
      ma = Dina::ManagedAttribute.new({ id: @id, group: "cnc", managedAttributeType: "NUMBER" })
      expect { ma.save }.to raise_error(Dina::PropertyValueInvalid)
    end

  end
end
