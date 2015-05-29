module SaxMachine

  class Error < StandardError
  end

  class BadTransitionAction < Error
  end

  class IllegalEvent < Error
  end

end
