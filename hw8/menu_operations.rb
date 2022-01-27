# frozen_string_literal: true

# MenuOperations module
module MenuOperations
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
    return if @trains.empty?

    print_trains
    puts 'Выберите поезд и объем вагона (количество мест)'
    train_number = gets.to_i
    case @trains[train_number].type
    when 'cargo' then @trains[train_number].add_wagon(gets.to_i)
    when 'passenger' then @trains[train_number].add_wagon(gets.to_i)
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
    return if @trains.empty?

    print_trains
    puts 'Выберите поезд'
    train_number = gets.to_i
    if @trains[train_number].route.nil?
      puts 'У этого поезда нет маршрута'
    else
      @trains[train_number].go_to_next_station
    end
  end

  def go_to_prev_station
    return if trains.empty?

    print_trains
    puts 'Выберите поезд'
    train_number = gets.to_i
    if @trains[train_number].route.nil?
      puts 'У этого поезда нет маршрута'
    else
      @trains[gets.to_i].go_to_prev_station
    end
  end

  def show
    @stations.each do |station|
      puts station.name
      print_trains_on_station(station) { |train| print_wagons(train) }
    end
    gets
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
    puts 'В каком поезде и вагоне вы хотите занять место? Если вагон грузовой, то укажите объем.'
    train = trains[gets.to_i]
    print_wagons(train)
    wagon = train.wagons[gets.to_i]
    if wagon.type == 'cargo'
      wagon.occupy_volume(gets.to_i)
    else
      wagon.add_passenger
    end
  end
end
