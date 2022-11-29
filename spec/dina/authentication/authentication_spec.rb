module Dina
  describe 'Authentication' do

    before(:all) do
      @token_store_file = Tempfile.new
      @config = {
        token_store_file: @token_store_file.path,
        authorization_url: "http://localhost/auth",
        endpoint_url: "http://localhost/api/",
        client_id: "objectstore",
        realm: "readme",
        server_name: "dina",
        user: "cnc-su",
        password: "cnc-su"
      }
    end

    after(:all) do
      @token_store_file.flush
    end

    describe "It should authenticate and store tokens" do

      it "should read a token file" do
        expect(@token_store_file.path).to eq(@config[:token_store_file])
      end

      it "should be able to set the token store file" do
        Dina::Authentication.token_store_file = @config[:token_store_file]
        expect(Dina::Authentication.token_store_file).to eq(@config[:token_store_file])
      end

      it "should be able to send a config hash to Authentication" do
        Dina::Authentication.config(@config)
        expect(Dina::Authentication.token_store_file).to eq(@config[:token_store_file])
      end

      it "should have set Keycloak settings when config variables are passed" do
        Dina::Authentication.config(@config)
        expect(Keycloak.auth_server_url).to eq(Dina::Authentication.authorization_url)
      end

    end

  end
end
