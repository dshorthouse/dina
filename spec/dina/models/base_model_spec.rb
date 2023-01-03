module Dina
  describe 'BaseModel' do

    before(:each) do
      @id = SecureRandom.uuid
    end

    it "should create an object of type BaseModel" do
      base = BaseModel.new
      expect(base).to be_a(BaseModel)
    end

    it "should raise an Exception if config has not yet been called" do
      expect { BaseModel.site }.to raise_error(ConfigItemMissing)
    end

  end
end
