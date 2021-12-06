# frozen_string_literal: true

# Station class
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by(type)
    @trains.select { |train| train if train.type == type }
  end

  def count_trains_by(type)
    trains_by(type).size
  end

  def send_train(train)
    trains.delete train
  end
end

# Route class
class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(name)
    @stations.insert(-2, name)
  end

  def delete_station(name)
    @stations.delete(name)
  end

  def print
    @stations.each { |station| puts station.name }
  end
end

# Train class
class Train
  attr_accessor :speed
  attr_reader :wagons, :type, :cur_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @cur_station = nil
    @speed = 0
  end

  def accelerate(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def change_wagons(operation)
    if !@speed.zero?
      puts 'You need to stop the train first!'
    elsif operation == 'inc'
      @wagons += 1
    elsif operation == 'dec'
      @wagons -= 1
    end
  end

  def route=(route)
    @route = route
    @cur_station = @route.stations.first
  end

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

  def go_to_next_station
    @cur_station = next_station
  end

  def go_to_prev_station
    @cur_station = prev_station
  end
end
