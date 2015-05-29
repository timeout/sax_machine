require 'sax_machine/stack'
require 'sax_machine/transitions'
require 'sax_machine/state_factory'
require 'sax_machine/start_state'

module SaxMachine
  class StateMachine

    def initialize(start_state = SaxMachine::StartState.new, &block)
      @state = start_state
      @transitions = SaxMachine::Transitions.new(&block)
      @stack = SaxMachine::Stack.new
      @stack.push(@state)
    end

    attr_reader :state, :stack, :transitions

    def state_name
      self.state.name
    end

    def on_start_element(name)
      p "#{__method__}(#{name}, #{self.state})"
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

