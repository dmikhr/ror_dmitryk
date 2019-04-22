# класс Поезд
class Train
  include ProductionCompany
  include InstanceCounter

  attr_reader :number, :carriages

  @@trains = []
  # метод класса - поиск инстанса поезда по номеру
  def self.find(number)
    @@trains.select { |train| train.number == number }[0]
  end

  def initialize(number, type)
    register_instance
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    @@trains << self
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
