# frozen_string_literal: true

require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

# Train class
class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :route, :number, :wagons, :type, :cur_station, :speed

  VALID_NUMBER = /^\w{3}-?\w{2}$/.freeze

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @wagons = []
    @cur_station = nil
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def wagons_each(&block)
    @wagons.each_with_index(&block)
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

  def validate!
    raise 'Формат номера неверный' if @number !~ VALID_NUMBER
    raise 'Тип поезда может быть только cargo либо passenger' if @type != 'cargo' && @type != 'passenger'
    raise 'Номер поезда должен быть уникальным' unless Train.find(@number).nil?
  end

  def next_station
    if @cur_station != @route.stations.last
      @route.stations[@route.stations.index(@cur_station) + 1]
    else
      puts 'Это последняя станция'
      @cur_station
    end
  end

  def prev_station
    if @cur_station != @route.stations.first
      @route.stations[@route.stations.index(@cur_station) - 1]
    else
      puts 'Это первая станция'
      @cur_station
    end
  end
end
