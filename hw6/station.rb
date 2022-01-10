# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/validation'

# Station class
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def self.find(name)
    Station.all.find { |station| station.name == name }
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def accept_train(train)
    @trains << train
  end

  def count_trains_by(type)
    trains_by(type).size
  end

  def send_train(train)
    trains.delete train
  end

  # Согласно принципам инкапсуляции, мы скрываем реализацию внутреннего метода
  # Этот метод не будет использоваться в дочернем классе, поэтому можем
  # поместить его в private

  private

  def validate!
    raise 'Название станции не должно быть пустым' if @name == ('' || ' ')
    raise 'Название станции должно быть уникальным' if Station.find(@name) != nil
  end

  def trains_by(type)
    @trains.select { |train| train if train.type == type }
  end
end
