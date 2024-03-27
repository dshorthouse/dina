
module Dina
  describe 'AgentRole' do

    before(:each) do
      @agent_role = AgentRole.new
    end

    it "should create an object of type AgentRole" do
      expect(@agent_role).to be_a(AgentRole)
    end

    it "should create an object of type AgentRole with a default agent" do
      expect(@agent_role.agent).to eq([])
    end

    it "should add an agent" do
      id = SecureRandom.uuid_v7
      @agent_role.add_agent(id)
      expect(@agent_role.agent).to eq([ id ])
    end

    it "should raise an Exception if Agent is not a UUID" do
      expect { @agent_role.add_agent("12345") }.to raise_error(PropertyValueInvalid, "Agent must be a UUID.")
    end

  end
end
