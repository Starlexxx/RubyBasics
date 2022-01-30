# frozen_string_literal: true

# Menu module
module Menu
  OPERATIONS = ['1. Операции над поездами',
                '2. Операции над станциями',
                '3. Операции над маршрутами',
                '4. Генерация тестовых данных',
                '5. Выход'].freeze

  TRAIN_OPERATIONS = ['1. Создать поезд',
                      '2. Добавить вагон к поезду',
                      '3. Убрать вагон',
                      '4. Переместить поезд вперед по маршруту',
                      '5. Переместить поезд назад по маршруту',
                      '6. Занять место в вагоне'].freeze

  STATION_OPERATIONS = ['1. Создать станцию',
                        '2. Вывод станций и поездов'].freeze

  ROUTE_OPERATIONS = ['1. Создать маршрут',
                      '2. Добавить станцию в маршрут',
                      '3. Убрать станцию из маршрута',
                      '4. Назначить маршрут поезду'].freeze

  def menu
    loop do
      options(OPERATIONS)
      case gets.to_i
      when 1 then train_menu
      when 2 then station_menu
      when 3 then route_menu
      when 4 then seed
      when 5 then break
      end
    end
  end

  def train_menu
    options(TRAIN_OPERATIONS)
    case gets.to_i
    when 1 then create_train
    when 2 then add_wagon
    when 3 then delete_wagon
    when 4 then go_to_next_station
    when 5 then go_to_prev_station
    when 6 then occupy_wagon
    end
    system 'clear'
  end

  def station_menu
    options(STATION_OPERATIONS)
    case gets.to_i
    when 1 then create_station
    when 2 then show
    end
    system 'clear'
  end

  def route_menu
    options(ROUTE_OPERATIONS)
    case gets.to_i
    when 1 then create_route
    when 2 then add_station
    when 3 then delete_station
    when 4 then assign_route
    end
    system 'clear'
  end

  def options(array)
    puts 'Что вы хотите сделать?
    ------------------'
    array.each { |option| puts option }
    puts "\n"
  end
end
