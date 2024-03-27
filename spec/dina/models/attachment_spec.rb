module Dina
  describe 'Attachment' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Attachment" do
      attach = Attachment.new
      expect(attach).to be_a(Attachment)
    end

    it "should create an object of type Attachment with a UUID as id" do
      attach = Attachment.new
      expect(attach.id).to be_a_uuid
    end

    it "should create an object of type Attachment with default attributes" do
      attach = Attachment.new({ id: @id })
      expect(attach.attributes).to eq({"type"=>"attachment", "id" => @id })
    end

  end
end
