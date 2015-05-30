require 'ox'

module SaxMachine
  class Handler < Ox::Sax

    def initialize(state_machine)
      @state_machine = state_machine
    end

    attr_reader :state_machine

    def start_element(name)
      self.state_machine.on_start_element name
    end

    def end_element(name)
      self.state_machine.on_end_element name
    end

    def attr_name(name, value)
    end

    def text(value)
      self.state_machine.on_text value
    end

  end
end
