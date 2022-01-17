# frozen_string_literal: true

# CargoWagon class
class CargoWagon < Wagon
  attr_reader :volume, :available_volume, :occupied_volume

  def initialize(volume, type = 'cargo')
    super(type)
    @volume = @available_volume = volume
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    return unless @available_volume.positive? && volume <= @available_volume

    @occupied_volume += volume
    @available_volume -= volume
  end

  private

  attr_writer :available_volume, :occupied_volume
end
