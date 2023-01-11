module Dina
  describe 'Assemblage' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Assemblage" do
      assemblage = Assemblage.new
      expect(assemblage).to be_a(Assemblage)
    end

    it "should create an object of type Assemblage with a UUID as id" do
      assemblage = Assemblage.new
      expect(assemblage.id).to be_a_uuid
    end

    it "should create an object of type Assemblage with default attributes" do
      assemblage = Assemblage.new({ id: @id })
      expect(assemblage.attributes).to eq({"type"=>"assemblage", "id" => @id })
    end

    it "can have many attachments" do
      assemblage = Assemblage.new({ attachment: [ Attachment.new ]})
      expect(assemblage.attachment.size).to eq(1)
    end

    it "can have a multilingual title" do
      assemblage = Assemblage.new
      assemblage.multilingualTitle = { english: "My assemblage", french: "Mon assemblage" }
      expect(assemblage.multilingualTitle).to eq("titles" => [{ "lang" => "en", "title" => "My assemblage" }, { "lang" => "fr", "title" => "Mon assemblage" }])
    end

    it "can have a multilingual description" do
      assemblage = Assemblage.new
      assemblage.multilingualDescription = { english: "My assemblage", french: "Mon assemblage" }
      expect(assemblage.multilingualDescription).to eq("descriptions" => [{ "lang" => "en", "desc" => "My assemblage" }, { "lang" => "fr", "desc" => "Mon assemblage" }])
    end

    it "should raise an Exception if group is missing" do
      assemblage = Assemblage.new({ group: nil, name: "My assemblage" })
      expect { assemblage.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if name is missing" do
      assemblage = Assemblage.new({ group: "DINA", name: nil })
      expect { assemblage.save }.to raise_error(ObjectInvalid)
    end

  end
end
