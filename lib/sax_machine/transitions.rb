
module SaxMachine
  class Transitions

    def initialize
      @transitions = Array.new
      yield(self)
    end

    attr_reader :transitions

    def <<(transition)
      @transitions << transition
    end

    def push_transition(event, state)
      # puts "#{event} (#{event.class.name})"
      result = transition(:PushEvent, event, state)
      # TODO
      raise "Evil madness: more than one result: #{result}" if result.size > 1
      raise "Evil madness: no result: #{result}" if result.size == 0
      result.first
    end

    def pop_transition(event, state)
      self.transition(:PopEvent, event, state)
    end

    def text_transition(event, state)
      self.transition(:TextEvent, event, state)
    end

    def size
      @transitions.size
    end

    def to_s
      @transitions.collect { |trans| "#{trans.to_s}" }
        .join("/n")
    end

    private

    def transition(event_type, event, state)
      @transitions.keep_if do |trans|
        # Debug
        # puts "#{event} (#{event.class.name})"
        # puts "#{trans.event.event} (#{trans.event.event.class.name})"
        puts "state: #{state} (#{state.class.name})"
        puts "trans.state: #{trans.state} (#{trans.state.class.name})"

        trans if trans.event.event == event and 
          trans.state == state and 
          trans.event_type == event_type
      end
    end

  end
end

