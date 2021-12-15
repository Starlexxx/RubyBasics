# frozen_string_literal: true

# Route class
class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(start, finish)
    @stations = [start, finish]
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
end
