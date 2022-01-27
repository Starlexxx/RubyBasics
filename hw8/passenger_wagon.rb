# frozen_string_literal: true

# PassengerWagon class
class PassengerWagon < Wagon
  attr_reader :seats, :passengers, :available_seats

  def initialize(seats, type = 'passenger')
    super(type)
    @seats = @available_seats = seats
    @passengers = 0
  end

  def add_passenger
    return unless @available_seats.positive?

    @passengers += 1
    @available_seats -= 1
  end

  private

  attr_writer :available_seats, :passengers
end
