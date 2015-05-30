require 'sax_machine/state'

module SaxMachine
  class Front
    include State

    def initialize(name)
      @name = name
      @title = nil
    end

    attr_accessor :title

  end
end
