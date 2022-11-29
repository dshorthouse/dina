module Dina
  describe 'File' do

    it "should create an object of type File" do
      file = Dina::File.new
      expect(file).to be_a(Dina::File)
    end

  end
end
