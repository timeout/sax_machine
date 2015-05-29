require 'sax_machine/stack'
require 'sax_machine/transitions'
require 'sax_machine/state_factory'

module SaxMachine
  class StateMachine

    def initialize(start_state = nil, &block)
      @state = start_state
      @transitions = SaxMachine::Transitions.new(&block)
      @stack = SaxMachine::Stack.new
    end

    attr_reader :state, :stack, :transitions

    def on_start_element(name)
      p "#{__method__} #{name}, #{self.state}"
      transition = self.transitions.push_transition(name, self.state)
      if transition.event_type == :PushEvent
        @state = SaxMachine::StateFactory.create(name)
        @stack.push(@state)
      end
    end

    def on_end_element(name)
      @stack.pop
    end

    private

    attr_writer :state

  end
end

