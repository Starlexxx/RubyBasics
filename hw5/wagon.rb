# frozen_string_literal: true

# Wagon class
class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
