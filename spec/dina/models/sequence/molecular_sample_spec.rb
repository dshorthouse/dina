module Dina
  describe 'MolecularSample' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type MolecularSample" do
      molecular_sample = Dina::MolecularSample.new
      expect(molecular_sample).to be_a(Dina::MolecularSample)
    end

    it "should create an object of type MolecularSample with a UUID as id" do
      molecular_sample = Dina::MolecularSample.new
      expect(molecular_sample.id).to be_a_uuid
    end

  end
end
