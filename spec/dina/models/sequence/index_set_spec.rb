module Dina
  describe 'IndexSet' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type IndexSet" do
      index_set = Dina::IndexSet.new
      expect(index_set).to be_a(Dina::IndexSet)
    end

    it "should create an object of type IndexSet with a UUID as id" do
      index_set = Dina::IndexSet.new
      expect(index_set.id).to be_a_uuid
    end

  end
end
