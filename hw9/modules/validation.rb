# frozen_string_literal: true

# Validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Validation ClassMethods
  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << [[name, type, args[0]]]
    end
  end

  # Validation InstanceMethods
  module InstanceMethods
    def validate!
      return if self.class.validations.nil?

      self.class.validations.each do |validations_array|
        validations_array.each do |var, type, arg|
          send("#{type}_validate", instance_variable_get("@#{var}"), arg)
        end
      end
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def presence_validate(name, _)
    raise 'Переменная не должна быть пустой' if name.nil? || name == ''
  end

  def format_validate(name, format)
    raise "Переменная #{name} некорректна" if name !~ format
  end

  def type_validate(name, type)
    raise "#{name} неверного типа. Ожидалось: #{type}, Получено #{name.class}" unless name.is_a?(type)
  end
end
