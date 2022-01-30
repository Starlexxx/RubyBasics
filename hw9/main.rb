# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'seed'
require_relative 'modules/menu'
require_relative 'modules/menu_operations'

# Main class
class Main
  include Menu
  include MenuOperations
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  private

  def create_station
    puts 'Введите название станции'
    @stations << Station.new(gets.chomp)
  rescue RuntimeError
    puts 'Убедитесь, что не существует станции с таким названием'
    retry
  else
    puts 'Станция успешно создана!'
  end

  def create_train
    puts 'Введите 1, если хотите создать грузовой поезд и 2 если пассажирский и номер поезда'
    case gets.to_i
    when 1 then @trains << CargoTrain.new(gets.to_s)
    when 2 then @trains << PassengerTrain.new(gets.to_s)
    end
  rescue RuntimeError
    puts 'Убедитесь, что формат номера верный и что не существует поезда с таким номером'
    retry
  else
    puts 'Поезд успешно создан!'
  end

  def create_route
    print_stations
    puts 'Выберите начальную и конечную станции'
    @routes << Route.new(@stations[gets.to_i], @stations[gets.to_i])
  rescue RuntimeError
    puts 'Убедитесь, что существует хотя-бы две станции и начальная станция не совпадает с конечной'
    retry
  else
    puts 'Маршрут успешно создан!'
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
end

Main.new.menu
