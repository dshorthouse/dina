module Dina
  describe 'NgsWorkflow' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type NgsWorkflow" do
      ngs = Dina::NgsWorkflow.new
      expect(ngs).to be_a(Dina::NgsWorkflow)
    end

    it "should create an object of type NgsWorkflow with a UUID as id" do
      ngs = Dina::NgsWorkflow.new
      expect(ngs.id).to be_a_uuid
    end

  end
end
