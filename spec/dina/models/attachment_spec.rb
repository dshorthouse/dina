module Dina
  describe 'Attachment' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Attachment" do
      attach = Dina::Attachment.new
      expect(attach).to be_a(Dina::Attachment)
    end

    it "should create an object of type Attachment with a UUID as id" do
      attach = Dina::Attachment.new
      expect(attach.id).to be_a_uuid
    end

    it "should create an object of type Attachment with default attributes" do
      attach = Dina::Attachment.new({ id: @id })
      expect(attach.attributes).to eq({"type"=>"attachment", "id" => @id })
    end

  end
end
