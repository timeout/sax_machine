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
      @text = false
      @product = nil
    end

    attr_accessor :state
    attr_reader :stack, :transitions, :product

    def state_name
      self.state.name
    end

    def on_start_element(name)
      transition = self.transitions.push_transition(name, self.state) ||
        self.transitions.text_transition(name, self.state)
      if transition and transition.event_type == :PushEvent
        @state = SaxMachine::StateFactory.create(name)
        @stack.push(@state)
      end
      if transition and transition.event_type == :TextEvent
        toggle_text!
      end
    end

    def on_end_element(name)
      @product = @stack.peek if @stack.size == 2

      if @stack.size > 2
        old_state = @state
        @stack.pop
        @state = self.stack.peek
        method = "#{old_state.name}=".to_sym
        @state.send method, old_state if @state.respond_to? method
      else
        @stack.pop
      end
    end

    private

    def toggle_text!
      @text ^= true
    end

    def has_text?
      @text
    end

  end
end

