module SaxMachine

  class Error < StandardError
  end

  class TransitionError < Error
  end

  class BadTransitionAction < TransitionError
  end

  class NilStateName < TransitionError
  end

  class IllegalEvent < Error
  end

end
