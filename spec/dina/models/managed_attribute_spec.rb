module Dina
  describe 'ManagedAttribute' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type ManagedAttribute" do
      ma = ManagedAttribute.new
      expect(ma).to be_a(ManagedAttribute)
    end

    it "should create an object of type ManagedAttribute with a UUID as id" do
      ma = ManagedAttribute.new
      expect(ma.id).to be_a_uuid
    end

    it "should create an object of type ManagedAttribute with default attributes" do
      ma = ManagedAttribute.new({ id: @id })
      expect(ma.attributes).to eq({"id"=> @id, "type"=>"managed-attribute"})
    end

    it "should raise an Exception if group is missing" do
      ma = ManagedAttribute.new({ group: nil })
      expect { ma.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if name is missing" do
      ma = ManagedAttribute.new({ group: "DINA", name: nil, managedtAttributeType: "STRING" })
      expect { ma.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if managedtAttributeType is missing" do
      ma = ManagedAttribute.new({ group: "DINA", name: "test", managedtAttributeType: nil })
      expect { ma.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if managedAttributeComponent is invalid" do
      ma = ManagedAttribute.new({ id: @id, group: "cnc", managedAttributeComponent: "BIBLIO" })
      expect { ma.save }.to raise_error(PropertyValueInvalid)
    end

    it "should raise an Exception if managedAttributeType is invalid" do
      ma = ManagedAttribute.new({ id: @id, group: "cnc", managedAttributeType: "NUMBER" })
      expect { ma.save }.to raise_error(PropertyValueInvalid)
    end

  end
end
