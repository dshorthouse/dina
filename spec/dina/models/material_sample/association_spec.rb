module Dina
  describe 'Association' do

    before(:each) do
      @id = SecureRandom.uuid_v7
    end

    it "should create an object of type Association" do
      association = Association.new
      expect(association).to be_a(Association)
    end

    it "should create an object of type Association with default attributes" do
      association = Association.new({ id: @id })
      expect(association.attributes).to eq({"type"=>"association", "id"=>@id})
    end

    it "can have one sample" do
      association = Association.new({ sample: MaterialSample.new })
      expect(association.sample).to be_a(MaterialSample)
    end

    it "can have one associated sample" do
      association = Association.new({ associatedSample: MaterialSample.new })
      expect(association.associatedSample).to be_a(MaterialSample)
    end

  end
end