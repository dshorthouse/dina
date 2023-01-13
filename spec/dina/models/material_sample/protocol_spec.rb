module Dina
  describe 'Protocol' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Protocol" do
      protocol = Protocol.new
      expect(protocol).to be_a(Protocol)
    end

    it "should create an object of type Protocol with default attributes" do
      protocol = Protocol.new({ id: @id })
      expect(protocol.attributes).to eq({"type"=>"protocol", "id"=>@id})
    end

    it "can have many attachments" do
      protocol = Protocol.new
      expect(protocol.attachment).to be_nil
    end

    it "can have a multilingual description by sending a Hash" do
      protocol = Protocol.new
      protocol.multilingualDescription = { en: "My attribute", fr: "Mon propriété" }
      expect(protocol.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My attribute" }, { "lang" => "fr", "desc" => "Mon propriété" }])
    end

    it "should raise an Exception if group is missing" do
      protocol = Protocol.new({ group: nil })
      expect { protocol.save }.to raise_error(ObjectInvalid)
    end
  end
end
