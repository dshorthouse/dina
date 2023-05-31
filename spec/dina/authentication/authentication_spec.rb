module Dina
  describe 'Authentication' do

    before(:each) do
      @token_store_file = Tempfile.new
      @config = {
        token_store_file: @token_store_file.path,
        authorization_url: "http://localhost/auth",
        endpoint_url: "http://localhost/api",
        client_id: "objectstore",
        realm: "readme",
        user: "cnc-su",
        password: "cnc-su"
      }
      Dina.config = @config
    end

    after(:each) do
      Dina.flush
      Dina.flush_config
      @token_store_file.flush
      @config = {}
    end

    it "should populate an empty token file with nil values for keys" do
      token = JSON.parse(::File.read(@token_store_file), symbolize_names: true)
      expect(token).to eq({ access_token: nil, auth_expiry: nil, refresh_token: nil, expires_in: nil })
    end

    it "should raise an Exception if the token file is not found" do
      @config[:token_store_file] = "missing.json"
      expect { Dina.config = @config }.to raise_error(TokenStoreFileNotFound)
    end

    it "should raise an Exception if client_id is missing from config" do
      @config[:client_id] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing client_id from config.")
    end

    it "should raise an Exception if realm is missing from config" do
      @config[:realm] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing realm from config.")
    end

    it "should raise an Exception if user is missing from config" do
      @config[:user] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing user from config.")
    end

    it "should raise an Exception if password is missing from config" do
      @config[:password] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing password from config.")
    end

    it "should raise an Exception if authorization_url is missing from config" do
      @config[:authorization_url] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing authorization_url from config.")
    end

    it "should raise an Exception if endpoint_url is missing from config" do
      @config[:endpoint_url] = nil
      expect { Dina.config = @config }.to raise_error(ConfigItemMissing, "Missing endpoint_url from config.")
    end

    it "should flush the contents of the token file" do
      Dina.flush
      token = JSON.parse(::File.read(@token_store_file), symbolize_names: true)
      expect(token).to eq({ access_token: nil, auth_expiry: nil, refresh_token: nil, expires_in: nil })
    end

  end
end
