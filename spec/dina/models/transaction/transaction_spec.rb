module Dina
  describe 'Transaction' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Transaction" do
      trans = Transaction.new
      expect(trans).to be_a(Transaction)
    end

    it "should create an object of type Transaction with default attributes" do
      trans = Transaction.new({ id: @id })
      expect(trans.attributes).to eq({"type"=>"transaction", "id"=>@id, "otherIdentifiers" => []})
    end

    it "can have many material samples" do
      trans = Transaction.new
      expect(trans.material_samples).to be_nil
    end

    it "can have many attachments" do
      trans = Transaction.new({ attachment: [ Attachment.new ]})
      expect(trans.attachment.size).to eq(1)
    end

    it "can have many involvedAgents" do
      trans = Transaction.new({ involved_agents: [ Person.new ] })
      expect(trans.involved_agents.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      trans = Transaction.new({ group: nil, materialDirection: "IN" })
      expect { trans.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if materialDirection is missing" do
      trans = Transaction.new({ group: "CNC", materialDirection: nil })
      expect { trans.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if materialDirection is invalid" do
      trans = Transaction.new({ id: @id, group: "cnc", materialDirection: "UNSURE" })
      expect { trans.save }.to raise_error(PropertyValueInvalid)
    end

    it "should raise an Exception if openedDate is malformed" do
      trans = Transaction.new({ id: @id, group: "cnc", materialDirection: "IN" })
      expect { trans.openedDate = "today" }.to raise_error(PropertyValueInvalid)
    end

  end
end
