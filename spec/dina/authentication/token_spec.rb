module Dina
  describe 'Token' do

    before(:each) do
      @config = {
        token_store_file: mock_token_path,
        authorization_url: "http://localhost/auth",
        endpoint_url: "http://localhost/api",
        client_id: "objectstore",
        realm: "readme",
        server_name: "dina",
        user: "user",
        password: "password"
      }
      Dina::Authentication.config(@config)
    end

    after(:each) do
      @config = {}
      Dina::Authentication.endpoint_url = nil
    end

    it "should produce a header with a Bearer string" do
      expect(Dina::Authentication.header[0..5]).to eq("Bearer")
    end

    it "should produce a header whose Access token is included" do
      token = "Bearer " + mock_token[@config[:server_name].to_sym][:access_token]
      expect(Dina::Authentication.header).to eq(token)
    end

    it "should raise an Exception if the server_name is not found in the token file" do
      @config[:server_name] = "missing"
      Dina::Authentication.config(@config)
      expect { Dina::Authentication.header }.to raise_error(Dina::TokenStoreContentInvalid)
    end

  end
end
