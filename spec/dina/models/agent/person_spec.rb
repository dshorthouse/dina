module Dina
  describe 'Person' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    after(:each) do
      Dina.flush_config
    end

    it "should create an object of type Person" do
      person = Person.new
      expect(person).to be_a(Person)
    end

    it "should create an object of type Person with a UUID as id" do
      person = Person.new
      expect(person.id).to be_a_uuid
    end

    it "should create an object of type Person with default attributes" do
      person = Person.new({ id: @id })
      expect(person.attributes).to eq({"aliases"=>[], "id"=> @id, "type"=>"person"})
    end

    it "should create an object of type Person with default empty aliases" do
      person = Person.new
      expect(person.aliases).to eq([])
    end

    it "can have many organizations" do
      person = Person.new({ organizations: [ Organization.new, Organization.new ]})
      expect(person.organizations.size).to eq(2)
    end

    it "can have many identifiers" do
      person = Person.new({ identifiers: [ Identifier.new ]})
      expect(person.identifiers.size).to eq(1)
    end

    it "should raise an Exception if familyNames is missing" do
      person = Person.new({ familyNames: nil })
      expect { person.save }.to raise_error(ObjectInvalid)
    end

    it "should raise an Exception if config has not yet been called" do
      person = Person.new({ familyNames: "Pipetter" })
      expect { person.save }.to raise_error(ConfigItemMissing)
    end

    it "should throw a 404 error" do
      config = {
        token_store_file: mock_token_path,
        authorization_url: "http://localhost/auth",
        endpoint_url: "http://localhost/api",
        client_id: "objectstore",
        realm: "readme",
        server_name: "dina",
        user: "user",
        password: "password"
      }
      Dina.config = config
      person = Person.new({ familyNames: "Pipetter" })
      expect { person.save }.to raise_error(JsonApiClient::Errors::NotFound)
    end

  end
end
