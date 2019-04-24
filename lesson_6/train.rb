# класс Поезд
class Train
  include ProductionCompany
  include InstanceCounter
  include Validation

  attr_reader :number, :carriages

  # включая ^ (начало строки) и $ (конец строки) проверка идет на соответствие всей строки, а не на вхождение подстроки в строку
  # [а-яa-z0-9] - могут быть буквы русского и латинского алфавитов и цифры
  # (-)? - тире опционально, ? - 0 или 1 вхождение
  # i - регистронезависимое сравнение
  TRAIN_NUMBER_FORMAT = /^[а-яa-z0-9]{3}(-)?[а-яa-z0-9]{2}$/i

  # переменная класса - хеш для хранения инстансов поездов в формате номер_поезда => инстанс
  @@trains = {}
  # метод класса - поиск инстанса поезда по номеру
  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    @@trains[number] = self
    validate!
    register_instance
  end

  def add_carriage(carriage)
    @carriages << carriage if @speed.zero?
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if @speed.zero? && @carriages.size > 0
  end

  def move_next_station
    if @station_position < @route.stations.size - 1
      current_station.send_train(self)
      next_station.receive_train(self)
      @station_position += 1
    end
  end

  def move_back_station
    if @station_position > 0
      current_station.send_train(self)
      previous_station.receive_train(self)
      @station_position -= 1
    end
  end

  def receive_route(route)
    # принять маршрут
    @route = route
    # начальная станция маршрута принимает поезд
    @route.stations.first.receive_train(self)
    # задаем позицию станции, на которой находится поезд
    @station_position = 0
  end

  def speed_up(speed_increment)
    @speed += speed_increment
  end

  def slow_down(speed_decrement)
    if @speed - speed_decrement >= 0
      @speed -= speed_decrement
    end
  end

  protected
  # методы для внутреннего использования
  # protected вместо private, т.к. у класса будут подклассы

  attr_reader :speed, :type, :route

  def validate!
    raise 'Номер поезда должен быть текстовым' unless @number.class == String
    raise 'Номер поезда не задан' if @number == ''
    raise "Номер поезда #{@number} не соответствует формату" if @number !~ TRAIN_NUMBER_FORMAT
    raise 'Недопустимый тип поезда (должен быть "пассажирский" или "грузовой")' unless ['пассажирский', 'грузовой'].include?(@type)
  end

  def current_station
    @route.stations[@station_position]
  end

  def previous_station
    @route.stations[@station_position - 1] if @station_position - 1 >= 0
  end

  def next_station
    @route.stations[@station_position + 1] if @station_position + 1 < @route.stations.size
  end
end
