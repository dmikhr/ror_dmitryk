# класс пассажирского поезда
class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :number, :attrtype, String

  def initialize(number)
    super(number, 'пассажирский')
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == 'пассажирский'
  end
end
