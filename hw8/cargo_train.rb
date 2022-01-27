# frozen_string_literal: true

require_relative 'passenger_wagon'

# CargoTrain class
class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end

  def add_wagon(size)
    @wagons << CargoWagon.new(size)
  end
end
