module Dina
  describe 'PreparationMethod' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type PreparationMethod" do
      pm = PreparationMethod.new
      expect(pm).to be_a(PreparationMethod)
    end

    it "should create an object of type PreparationMethod with a UUID as id" do
      pm = PreparationMethod.new
      expect(pm.id).to be_a_uuid
    end

    it "should raise an Exception if group is missing" do
      pm = PreparationMethod.new({ group: nil })
      expect { pm.save }.to raise_error(ObjectInvalid)
    end

  end
end
