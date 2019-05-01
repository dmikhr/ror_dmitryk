# класс Грузовой вагон
class CargoCarriage < Carriage
  attr_reader :volume, :reserved_volume

  validate :id, :presence
  validate :id, :attrtype, String
  validate :type, :presence
  validate :type, :attrtype, String

  def initialize(id, volume)
    @volume = volume
    @reserved_volume = 0
    super(id, 'грузовой')
  end

  def reserve_volume(volume_to_reserve)
    @reserved_volume += volume_to_reserve if @reserved_volume + volume_to_reserve <= @volume
  end

  def show_free_volume
    @volume - @reserved_volume
  end
end
