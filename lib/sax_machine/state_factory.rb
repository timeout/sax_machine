module SaxMachine
  module StateFactory

    def self.create(start_name)
      state_class = SaxMachine.const_get("#{start_name.capitalize}")
      state_class.new(start_name)
    end

  end
end

