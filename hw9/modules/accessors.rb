# frozen_string_literal: true

# Accessors module
module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  # Acessors ClassMethods
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_setter_with_history(name)
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }
      end
    end

    def strong_attr_accessor(args = {})
      args.each do |name, arg_class|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          raise TypeError "Несовпадение типов: ожидалось #{arg_class.class}" unless value.is_a?(arg_class)

          instance_variable_set(var_name, value)
        end
      end
    end

    private

    def define_setter_with_history(name)
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_history, []) unless instance_variable_defined?(var_history)
        instance_variable_get(var_history) << value
      end
    end
  end
end
