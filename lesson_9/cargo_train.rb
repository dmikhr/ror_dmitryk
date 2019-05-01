# класс Грузовой поезд
class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :number, :attrtype, String

  def initialize(number)
    super(number, 'грузовой')
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == 'грузовой'
  end
end
