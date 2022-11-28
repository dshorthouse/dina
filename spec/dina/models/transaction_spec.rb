module Dina
  describe 'Transaction' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Transaction" do
      trans = Dina::Transaction.new
      expect(trans).to be_a(Dina::Transaction)
    end

    it "should create an object of type Transaction with default attributes" do
      trans = Dina::Transaction.new({ id: @id })
      expect(trans.attributes).to eq({"type"=>"transaction", "id"=>@id, "otherIdentifiers" => []})
    end

    it "can have many material samples" do
      trans = Dina::Transaction.new
      expect(trans.material_samples).to be_nil
    end

    it "can have many attachments" do
      trans = Dina::Transaction.new({ attachment: [ Dina::Attachment.new ]})
      expect(trans.attachment.size).to eq(1)
    end

    it "can have many involvedAgents" do
      trans = Dina::Transaction.new({ involved_agents: [ Dina::Person.new ] })
      expect(trans.involved_agents.size).to eq(1)
    end

  end
end
