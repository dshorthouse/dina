module Dina
  describe 'BaseModel' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type BaseModel" do
      base = Dina::BaseModel.new
      expect(base).to be_a(Dina::BaseModel)
    end

    it "should raise an Exception if config has not yet been called" do
      expect { Dina::BaseModel.site }.to raise_error(Dina::ConfigItemMissing)
    end

  end
end
