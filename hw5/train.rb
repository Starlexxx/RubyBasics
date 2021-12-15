# frozen_string_literal: true

# Train class
class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :route, :number, :wagons, :type, :cur_station, :speed

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @cur_station = nil
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def accelerate(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.type == @type
  end

  def delete_wagon
    @wagons.pop unless @wagons.empty?
  end

  def route=(route)
    @route = route
    @cur_station = @route.stations.first
  end

  def go_to_next_station
    @cur_station = next_station
  end

  def go_to_prev_station
    @cur_station = prev_station
  end

  # Согласно принципам инкапсуляции, скрываем внутренние методы. Они будут
  # использоваться в классах-наследниках, поэтому для возможности их
  # использования в дочерних классах, помещаем их в protected

  protected

  attr_writer :speed, :type

  def next_station
    if @cur_station != @route.stations.last
      @route.stations[@route.stations.index(@cur_station) + 1]
    else
      puts 'This is the last station'
      @cur_station
    end
  end

  def prev_station
    if @cur_station != @route.stations.first
      @route.stations[@route.stations.index(@cur_station) - 1]
    else
      puts 'This is the first station'
      @cur_station
    end
  end
end
