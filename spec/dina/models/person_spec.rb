module Dina
  describe 'Person' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Person" do
      person = Dina::Person.new
      expect(person).to be_a(Dina::Person)
    end

    it "should create an object of type Person with a UUID as id" do
      person = Dina::Person.new
      expect(person.id).to be_a_uuid
    end

    it "should create an object of type Person with default attributes" do
      person = Dina::Person.new({ id: @id })
      expect(person.attributes).to eq({"aliases"=>[], "id"=> @id, "type"=>"person"})
    end

    it "should create an object of type Person with default empty aliases" do
      person = Dina::Person.new
      expect(person.aliases).to eq([])
    end

    it "can have many organizations" do
      person = Dina::Person.new
      expect(person.organizations).to be_nil
    end

    it "can have many identifiers" do
      person = Dina::Person.new
      expect(person.identifiers).to be_nil
    end

  end
end
