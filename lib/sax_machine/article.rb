require 'sax_machine/state'

module SaxMachine
  class Article
    include State

    def initialize(name)
      @name = name
    end

  end
end
