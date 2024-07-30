module Dina
    describe 'StorageUnitUsage' do
  
      before(:each) do
        @id = SecureRandom.uuid_v7
      end
  
      it "should create an object of type StorageUnitUsage" do
        suu = StorageUnitUsage.new
        expect(suu).to be_a(StorageUnitUsage)
      end
  
      it "should create an object of type StorageUnitUsage with default attributes" do
        suu = StorageUnitUsage.new({ id: @id })
        expect(suu.attributes).to eq({"type"=>"storage-unit-usage", "id"=>@id})
      end
  
      it "should raise an Exception if group is missing" do
        suu = StorageUnitUsage.new({ group: nil, usageType: "material-sample" })
        expect { suu.save }.to raise_error(ObjectInvalid)
      end

      it "should raise an Exception if usageType is missing" do
        suu = StorageUnitUsage.new({ group: "dao", usageType: nil })
        expect { suu.save }.to raise_error(ObjectInvalid)
      end

    end
  end