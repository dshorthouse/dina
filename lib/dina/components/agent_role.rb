module Dina
  class AgentRole
    attr_accessor :agent #A known UUID for a Person
    attr_accessor :roles #an array of roles: Owner, Borrower, Prepared By
    attr_accessor :date
    attr_accessor :remarks

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

  end
end
