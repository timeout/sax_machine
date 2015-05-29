require 'sax_machine/state'

module SaxMachine
  class Front
    include State

    def initialize(name)
      @name = name
    end
  end
end
