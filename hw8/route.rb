# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/validation'

# Route class
class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :name

  def initialize(start, finish)
    @stations = [start, finish]
    validate!
    @name = "#{start.name} - #{finish.name}"
    register_instance
  end

  def add_station(name)
    @stations.insert(-2, name)
  end

  def delete_station(name)
    @stations.delete(name)
  end

  def print
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
  end

  private

  def validate!
    raise 'Начальная и конечная станции должны отличаться' if @stations.first == @stations.last
  end
end
