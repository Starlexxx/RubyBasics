# frozen_string_literal: true

# InstanceCounter module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # ClassMethods module
  module ClassMethods
    attr_writer :instances_counter

    def instances_counter
      @instances_counter ||= 0
    end
  end

  # InstanceMethods module
  module InstanceMethods
    private

    def register_instance
      self.class.instances_counter += 1
    end
  end
end
