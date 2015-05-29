require 'ox'

module SaxMachine
  class Handler < Ox::Sax

    def initialize(state_machine)
      @state_machine = state_machine
    end

    attr_reader :state_machine

    def start_element(name)
      self.state_machine.push name
    end

    def end_element(name)
      self.state_machine.pop name
    end

    def attr_name(name, value)
    end

    def text(value)
      self.state_machine.text value
    end

  end
end
