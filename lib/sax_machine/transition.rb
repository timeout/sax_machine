require 'sax_machine/exceptions'

module SaxMachine
  class Transition

    def initialize(event, state_name)
      state = :nil unless state
      @event, @state = event, state
    end

    attr_reader :event, :state

    def <=>(other)
      self.event <=> other.event
    end

    def eql?(other)
      self == other
    end

    def event_type
      self.event.class.name.split('::').last.to_sym || nil
    end

    def to_s
      case self.event_type
      when :PushEvent then
        "[ #{self.event} : push ] (#{self.state} \u2192 #{self.event})"
      when :PopEvent then
        "[ #{self.event} : pop ] (#{self.state} \u2190 #{self.event})"
      when :TextEvent then
        "[ #{self.event} : text ] (#{self.state})"
      else
        raise IllegalEvent.new("Illegal event: #{self.event_type.to_s}")
      end
    end
  end
end
