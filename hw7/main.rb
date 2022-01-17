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
      when 12 then seed
      when 13 then occupy_wagon
      when 0 then break
      end
    end
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
    puts 'Введите 1, если хотите создать грузовой поезд и 2 если пассажирский'
    choice = gets.to_i
    puts 'Введите номер поезда'
    case choice
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
        puts 'Введите объем вагона'
        @trains[train_number].add_wagon(CargoWagon.new(gets.to_i))
      else
        puts 'Введите количество мест'
        @trains[train_number].add_wagon(PassengerWagon.new(gets.to_i))
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
      print_trains_on_station(station) { |train| print_wagons(train) }
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
    12. Сгенерировать тестовые данные
    13. Занять место в вагоне
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

  def print_trains_on_station(station)
    station.trains_each do |train|
      puts 'train:'
      puts "#{train.number}, #{train.type}, wagons: #{train.wagons.size}"
      yield(train)
    end
  end

  def print_wagons(train)
    train.wagons_each do |wagon, index|
      puts 'wagon:'
      case wagon.type
      when 'cargo'
        puts "#{index}, #{wagon.type}, available volume: #{wagon.available_volume},
            occupied volume: #{wagon.occupied_volume}"
      when 'passenger'
        puts "#{index}, #{wagon.type}, available seats: #{wagon.available_seats},
            passengers: #{wagon.passengers}"
      end
    end
  end

  def occupy_wagon
    print_trains
    puts 'В каком поезде вы хотите занять место?'
    train = trains[gets.to_i]
    print_wagons(train)
    puts 'В каком вагоне вы хотите занять место?'
    wagon = train.wagons[gets.to_i]
    case wagon.type
    when 'cargo'
      puts 'Какое количество объема вы собираетесь занять?'
      wagon.occupy_volume(gets.to_i)
    when 'passenger'
      wagon.add_passenger
    end
  end
end

Main.new.menu
