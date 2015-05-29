module SaxMachine
  class Stack
    include Enumerable

    def initialize
      @data = Array.new
    end

    def push(element)
      @data << element
    end

    def pop
      result = @data.pop
      raise EmptyStack.new("Error: #{self.class.name} underflow. Bad transition?") if @data.empty?
      result
    end

    def peek
      @data.last
    end

    def size
      @data.size
    end

    def each
      @data.each { |d| yield(d) }
    end
  end
end
