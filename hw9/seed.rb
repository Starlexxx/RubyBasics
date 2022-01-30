# frozen_string_literal: true

def seed
  @stations = [station1 = Station.new('Moscow'), station2 = Station.new('Kyiv'), Station.new('Minsk')]
  @routes = [route1 = Route.new(station1, station2)]
  @trains = [train1 = PassengerTrain.new('123-12'), train2 = CargoTrain.new('qwert')]

  train1.route = route1

  station1.accept_train(train1)
  station2.accept_train(train2)

  train1.add_wagon(20)
  train2.add_wagon(120)
end
