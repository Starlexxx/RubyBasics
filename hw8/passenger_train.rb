# frozen_string_literal: true

require_relative 'passenger_wagon'

# PassengerTrain class
class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def add_wagon(size)
    @wagons << PassengerWagon.new(size)
  end
end
