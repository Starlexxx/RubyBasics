# frozen_string_literal: true

# CargoTrain class
class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end
end
