module Dina
  describe 'Assemblage' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Assemblage" do
      assemblage = Dina::Assemblage.new
      expect(assemblage).to be_a(Dina::Assemblage)
    end

    it "should create an object of type Assemblage with a UUID as id" do
      assemblage = Dina::Assemblage.new
      expect(assemblage.id).to be_a_uuid
    end

    it "should create an object of type Assemblage with default attributes" do
      assemblage = Dina::Assemblage.new({ id: @id })
      expect(assemblage.attributes).to eq({"type"=>"assemblage", "id" => @id })
    end

    it "can have many attachments" do
      assemblage = Dina::Assemblage.new({ attachment: [ Dina::Attachment.new ]})
      expect(assemblage.attachment.size).to eq(1)
    end

    it "should raise an Exception if group is missing" do
      assemblage = Dina::Assemblage.new({ group: nil, name: "My assemblage" })
      expect { assemblage.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if group is missing" do
      assemblage = Dina::Assemblage.new({ group: "DINA", name: nil })
      expect { assemblage.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
