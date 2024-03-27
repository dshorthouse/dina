module Dina
  describe 'Organization' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Organization" do
      org = Organization.new
      expect(org).to be_a(Organization)
    end

    it "should create an object of type Organization with default attributes" do
      org = Organization.new({ id: @id })
      default = {
        "type" => "organization",
        "id" => @id,
        "aliases" => [],
        "names" => [
          {
            "languageCode" => "EN",
            "name" => nil
          },
          {
            "languageCode" => "FR",
            "name" => nil
          }
        ]
      }
      expect(org.attributes).to eq(default)
    end

  end
end
