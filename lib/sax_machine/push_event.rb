require 'sax_machine/event_spaceship'

module SaxMachine
  class PushEvent
    include EventSpaceship

    def initialize(event)
      @event = event
    end

    attr_reader :event

    def to_s
      "#{self.event}"
    end
  end
end
