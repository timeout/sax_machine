require 'sax_machine/state'

module SaxMachine
  class StartState
    include State

    def initialize
      @name = :nil
    end

  end
end
