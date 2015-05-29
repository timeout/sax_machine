require 'sax_machine/state_machine'

require 'ox'

module SaxMachine
  class ArticleHandler < Ox::Sax

    def initialize(&transitions)
      @state_machine = SaxMachine::StateMachine(&transitons)
    end

    def start_element(name)
      @state_machine.on_start_element(name)
    end

    def end_element(name)
      @start_element.on_end_element(name)
    end

    def attr(name, value)
    end

    def text(value)
    end

  end
end
