# frozen_string_literal: true

# Station class
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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

  def trains_by(type)
    @trains.select { |train| train if train.type == type }
  end
end
