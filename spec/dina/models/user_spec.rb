module Dina
  describe 'User' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type User" do
      user = Dina::User.new
      expect(user).to be_a(Dina::User)
    end

    it "should create an object of type User with a UUID as id" do
      user = Dina::User.new
      expect(user.id).to be_a_uuid
    end

    it "should create an object of type User with default attributes" do
      user = Dina::User.new({ id: @id })
      expect(user.attributes).to eq({"type"=>"user", "id" => @id })
    end

    it "should raise an Exception if username is missing" do
      user = Dina::User.new({ username: nil })
      expect { user.save }.to raise_error(Dina::ObjectInvalid)
    end

  end
end
