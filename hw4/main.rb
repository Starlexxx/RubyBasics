# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

# Main class
class Main
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def menu
    loop do
      puts 'Что вы хотите сделать?'
      options
      operation = gets.to_i
      case operation
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station
      when 5 then delete_station
      when 6 then assign_route
      when 7 then add_wagon
      when 8 then delete_wagon
      when 9 then go_to_next_station
      when 10 then go_to_prev_station
      when 11 then show
      when 0 then break
      end
    end
  end

  private

  def create_station
    puts 'Введите название станции'
    @stations << Station.new(gets.chomp)
  end

  def create_train
    puts 'Введите номер поезда и выберите тип'
    @trains << Train.new(gets.to_i, gets.chomp)
  end

  def create_route
    print_stations
    puts 'Выберите начальную и конечную станции'
    @routes << Route.new(@stations[gets.to_i], @stations[gets.to_i])
  end

  def add_station
    if @routes.empty? || @stations.empty?
      print 'Нет путей, либо станций'
    else
      print_routes
      puts 'Выберите номер маршрута'
      route_number = gets.to_i
      print_stations
      puts 'Выберите станцию'
      @routes[route_number].add_station(@stations[gets.to_i])
    end
  end

  def delete_station
    if @routes.empty? || @stations.empty?
      print 'Нет путей, либо станций'
    else
      print_routes
      puts 'Выберите номер маршрута'
      route_number = gets.to_i
      @routes[route_number].print
      puts 'Выберите станцию'
      @routes[route_number].delete_station(@stations[gets.to_i])
    end
  end

  def assign_route
    if @trains.empty? || @routes.empty?
      puts 'Нет поездов, либо путей'
    else
      print_trains
      puts 'Выберите поезд'
      train_number = gets.to_i
      print_routes
      puts 'Выберите маршрут'
      @trains[train_number].route = @routes[gets.to_i]
    end
  end

  def add_wagon
    if @trains.empty?
      puts 'Нет поездов'
    else
      print_trains
      puts 'Выберите поезд'
      train_number = gets.to_i
      if @trains[train_number].type == 'cargo'
        @trains[train_number].add_wagon(CargoWagon.new)
      else
        @trains[train_number].add_wagon(PassengerWagon.new)
      end
    end
  end

  def delete_wagon
    if @trains.empty?
      puts 'Нет поездов'
    else
      print_trains
      puts 'Выберите поезд'
      @trains[gets.to_i].delete_wagon
    end
  end

  def go_to_next_station
    if @trains.empty?
      puts 'Нет поездов'
    else
      print_trains
      puts 'Выберите поезд'
      train_number = gets.to_i
      if @trains[train_number].route.nil?
        puts 'У этого поезда нет маршрута'
      else
        @trains[train_number].go_to_next_station
      end
    end
  end

  def go_to_prev_station
    if @trains.empty?
      puts 'Нет поездов'
    else
      print_trains
      puts 'Выберите поезд'
      train_number = gets.to_i
      if @trains[train_number].route.nil?
        puts 'У этого поезда нет маршрута'
      else
        @trains[gets.to_i].go_to_prev_station
      end
    end
  end

  def show
    @stations.each do |station|
      puts station.name
      station.trains.each do |train|
        puts train.number.to_s
      end
    end
  end

  def options
    print 'Меню
    ------------------
    1. Создать станцию
    2. Создать поезд
    3. Создать маршрут
    4. Добавить станцию в маршрут
    5. Удалить станцию из маршрута
    6. Назначить маршрут поезду
    7. Добавить вагон к поезду
    8. Отцепить вагон от поезда
    9. Переместить поезд вперед по маршруту
    10. Переместить поезд назад по маршруту
    11. Показать станции и поезда
    0. Выход'
    puts "\n"
  end

  def print_routes
    @routes.each_with_index { |route, index| puts "#{index}. #{route.name}" }
  end

  def print_stations
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
  end

  def print_trains
    @trains.each_with_index { |train, index| puts "#{index}. #{train.number}" }
  end
end

Main.new.menu
