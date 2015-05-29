module SaxMachine
  module EventSpaceship

    def <=>(other)
      self.event <=> other.event
    end

    def ==(other)
      self <=> other
    end

    def eql?(other)
      self == other
    end

  end
end
