require 'sax_machine/exceptions'

module SaxMachine
  class Transition

    def initialize(event, state_name = :nil)
      raise NilStateName.new('Error: Transition state_name is nil') if state_name.nil?
      @event, @state_name = event, state_name
    end

    attr_reader :event, :state_name

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
        "[ #{self.event} : push ] (#{self.state_name} \u2192 #{self.event})"
      when :PopEvent then
        "[ #{self.event} : pop ] (#{self.state_name} \u2190 #{self.event})"
      when :TextEvent then
        "[ #{self.event} : text ] (#{self.state_name})"
      else
        raise IllegalEvent.new("Illegal event: #{self.event_type.to_s}")
      end
    end
  end
end
