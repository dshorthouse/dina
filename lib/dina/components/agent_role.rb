module Dina
  class AgentRole
    attr_accessor :agent #An array of known UUIDs for a Person
    attr_accessor :roles #An array of roles: Owner, Borrower, Prepared By
    attr_accessor :date
    attr_accessor :remarks

    def initialize
      @agent = []
      @roles = []
    end

    def add_agent(id)
      raise PropertyValueInvalid, "Agent must be a UUID." if !id.is_uuid?
      @agent << id
    end

    def add_role(role)
      @roles << role
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
