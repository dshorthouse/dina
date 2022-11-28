module Dina
  describe 'Protocol' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Protocol" do
      protocol = Dina::Protocol.new
      expect(protocol).to be_a(Dina::Protocol)
    end

    it "should create an object of type Protocol with default attributes" do
      protocol = Dina::Protocol.new({ id: @id })
      expect(protocol.attributes).to eq({"type"=>"protocol", "id"=>@id})
    end

    it "can have many attachments" do
      protocol = Dina::Protocol.new
      expect(protocol.attachment).to be_nil
    end

  end
end
