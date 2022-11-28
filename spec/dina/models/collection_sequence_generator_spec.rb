module Dina
  describe 'CollectionSequenceGenerator' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type CollectionSequenceGenerator" do
      seq = Dina::CollectionSequenceGenerator.new
      expect(seq).to be_a(Dina::CollectionSequenceGenerator)
    end

    it "should create an object of type CollectionSequenceGenerator with a UUID as id" do
      seq = Dina::CollectionSequenceGenerator.new
      expect(seq.id).to be_a_uuid
    end

    it "should create an object of type CollectionSequenceGenerator with default attributes" do
      seq = Dina::CollectionSequenceGenerator.new({ id: @id })
      expect(seq.attributes).to eq({"type"=>"collection-sequence-generator", "id" => @id })
    end

  end
end
