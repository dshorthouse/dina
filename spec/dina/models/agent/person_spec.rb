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
      person = Dina::Person.new({ organizations: [ Dina::Organization.new, Dina::Organization.new ]})
      expect(person.organizations.size).to eq(2)
    end

    it "can have many identifiers" do
      person = Dina::Person.new({ identifiers: [ Dina::Identifier.new ]})
      expect(person.identifiers.size).to eq(1)
    end

    it "should raise an Exception if familyNames is missing" do
      person = Dina::Person.new({ familyNames: nil })
      expect { person.save }.to raise_error(Dina::ObjectInvalid)
    end

    it "should raise an Exception if config has not yet been called" do
      person = Dina::Person.new({ familyNames: "Pipetter" })
      expect { person.save }.to raise_error(Dina::ConfigItemMissing)
    end

  end
end
