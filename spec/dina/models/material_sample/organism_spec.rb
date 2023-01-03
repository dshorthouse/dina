module Dina
  describe 'Organism' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Organism" do
      org = Organism.new
      expect(org).to be_a(Organism)
    end

    it "should create an object of type Organism with default attributes" do
      org = Organism.new({ id: @id })
      expect(org.attributes).to eq({"type"=>"organism", "id"=>@id, "determination"=>[]})
    end

    it "should raise an Exception if group is missing" do
      org = Organism.new({ group: nil })
      expect { org.save }.to raise_error(ObjectInvalid)
    end

  end
end
