module Dina
  describe 'User' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type User" do
      user = User.new
      expect(user).to be_a(User)
    end

    it "should create an object of type User with a UUID as id" do
      user = User.new
      expect(user.id).to be_a_uuid
    end

    it "should create an object of type User with default attributes" do
      user = User.new({ id: @id })
      expect(user.attributes).to eq({"type"=>"user", "id" => @id })
    end

    it "should raise an Exception if username is missing" do
      user = User.new({ username: nil })
      expect { user.save }.to raise_error(ObjectInvalid)
    end

    it "should create a new UUID for every new instance created" do
      user = User.new
      user2 = User.new
      expect(user.id).not_to eq(user2.id)
    end

  end
end
