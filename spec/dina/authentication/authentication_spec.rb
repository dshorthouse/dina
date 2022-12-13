module Dina
  describe 'Authentication:' do

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

    describe "It should authenticate and store tokens and it" do

      it "should populate an empty token file with nil values for keys" do
        Dina::Authentication.config(@config)
        token = JSON.parse(::File.read(@token_store_file), symbolize_names: true)
        expect(token).to eq({ dina: { access_token: nil, auth_expiry: nil, refresh_token: nil }})
      end

      it "should raise an Exception if the token file is not found" do
        @config[:token_store_file] = "missing.json"
        expect { Dina::Authentication.config(@config) }.to raise_error(Dina::TokenStoreFileNotFound)
      end

      it "should raise an Exception if there is a config element missing" do
        @config[:client_id] = nil
        expect { Dina::Authentication.config(@config) }.to raise_error(Dina::ConfigItemMissing)
      end

    end

  end
end
