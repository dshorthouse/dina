module Dina
  class ScheduledAction
    attr_accessor :actionType
    attr_accessor :date
    attr_accessor :actionStatus
    attr_accessor :remarks
    attr_accessor :assignedTo

    def initialize
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash.deep_symbolize_keys
    end

  end
end
