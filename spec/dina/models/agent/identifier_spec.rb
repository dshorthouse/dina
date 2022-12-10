module Dina
  describe 'Identifier' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Identifier" do
      id = Dina::Identifier.new
      expect(id).to be_a(Dina::Identifier)
    end

    it "should create an object of type Identifier with default attributes" do
      id = Dina::Identifier.new({ id: @id })
      expect(id.attributes).to eq({"type"=>"identifier", "id"=>@id})
    end

  end
end
