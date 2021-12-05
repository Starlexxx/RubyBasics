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

  def show_types
    cargos = passengers = 0
    @trains.each do |train|
      case train.type
      when 'cargo'
        cargos += 1
      when 'passenger'
        passengers += 1
      end
    end
    puts "There are #{cargos} cargo's and #{passengers} passenger trains on the station"
  end

  def send_train(train)
    trains.delete train
  end
end

# Route class
class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
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
  attr_reader :wagons, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @qur_station = nil
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
    @qur_station = @route.stations.first
  end

  def change_station(operation)
    case operation
    when 'inc'
      @qur_station = @route.stations[@route.stations.index(@qur_station) + 1]
    when 'dec'
      @qur_station = @route.stations[@route.stations.index(@qur_station) - 1]
    end
  end

  def print_stations_nearby
    puts @route.stations[@route.stations.index(@qur_station) - 1].name
    puts @qur_station.name
    puts @route.stations[@route.stations.index(@qur_station) + 1].name
  end
end
