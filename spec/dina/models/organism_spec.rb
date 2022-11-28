module Dina
  describe 'Organism' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Organism" do
      org = Dina::Organism.new
      expect(org).to be_a(Dina::Organism)
    end

    it "should create an object of type Organism with default attributes" do
      org = Dina::Organism.new({ id: @id })
      expect(org.attributes).to eq({"type"=>"organism", "id"=>@id, "determination"=>[]})
    end

  end
end
