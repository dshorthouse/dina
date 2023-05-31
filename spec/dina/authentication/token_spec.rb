module Dina
  describe 'Token' do

    before(:each) do
      @config = {
        token_store_file: mock_token_path,
        authorization_url: "http://localhost/auth",
        endpoint_url: "http://localhost/api",
        client_id: "objectstore",
        realm: "readme",
        user: "user",
        password: "password"
      }
      Dina.config = @config
    end

    after(:each) do
      @config = {}
      Dina.flush_config
    end

    it "should produce a header with a Bearer string" do
      expect(Dina.header[0..5]).to eq("Bearer")
    end

    it "should produce a header whose Access token is included" do
      token = "Bearer " + mock_token[:access_token]
      expect(Dina.header).to eq(token)
    end

  end
end
