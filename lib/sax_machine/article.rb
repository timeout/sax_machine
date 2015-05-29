require 'sax_machine/state'

module SaxMachine
  class Article
    include State

    def initialize(name)
      @name = name
      @front = nil
    end

    attr_accessor :front

  end
end
