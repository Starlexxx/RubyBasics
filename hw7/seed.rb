# frozen_string_literal: true

def seed
  station1 = Station.new('Moscow')
  station2 = Station.new('Kyiv')
  station3 = Station.new('Minsk')

  route1 = Route.new(station1, station2)

  train1 = PassengerTrain.new('123-12')
  train2 = CargoTrain.new('qwert')

  train1.route = route1

  station1.accept_train(train1)
  station2.accept_train(train2)

  wagon1 = PassengerWagon.new(20)
  wagon2 = CargoWagon.new(120)

  train1.add_wagon(wagon1)
  train2.add_wagon(wagon2)

  @stations = [station1, station2, station3]
  @routes = [route1]
  @trains = [train1, train2]
end
