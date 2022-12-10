module Dina
  describe 'Organization' do

    before(:all) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type Organization" do
      org = Dina::Organization.new
      expect(org).to be_a(Dina::Organization)
    end

    it "should create an object of type Organization with default attributes" do
      org = Dina::Organization.new({ id: @id })
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
