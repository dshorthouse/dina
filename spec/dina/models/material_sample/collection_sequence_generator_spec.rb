module Dina
  describe 'CollectionSequenceGenerator' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type CollectionSequenceGenerator" do
      seq = CollectionSequenceGenerator.new
      expect(seq).to be_a(CollectionSequenceGenerator)
    end

    it "should create an object of type CollectionSequenceGenerator with a UUID as id" do
      seq = CollectionSequenceGenerator.new
      expect(seq.id).to be_a_uuid
    end

    it "should create an object of type CollectionSequenceGenerator with default attributes" do
      seq = CollectionSequenceGenerator.new({ id: @id })
      expect(seq.attributes).to eq({"type"=>"collection-sequence-generator", "id" => @id })
    end

  end
end
