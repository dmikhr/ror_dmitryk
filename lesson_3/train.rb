# класс Поезд
class Train
  attr_reader :speed, :number, :type, :carriage_num

  def initialize(number, type, carriage_num)
    @number = number
    @type = type
    @carriage_num = carriage_num
    @speed = 0
  end

  def speed_up(speed_increment)
    @speed += speed_increment
  end

  def slow_down(speed_decrement)
    if @speed - speed_decrement >= 0
      @speed -= speed_decrement
    else
      puts 'Скорость не может быть меньше 0'
    end
  end

  def add_carriage
    if @speed.zero?
      @carriage_num += 1
    else
      puts 'Остановите поезд, чтобы прицепить вагон'
    end
  end

  def remove_carriage
    if @speed.zero?
      if @carriage_num > 0
        @carriage_num -= 1
      else
        puts 'Вагонов не может быть меньше 0'
      end
    else
      puts 'Остановите поезд, чтобы отцепить вагон'
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

  def move_next_station
    if @station_position < @route.stations.size - 1
      current_station.send_train(self)
      next_station.receive_train(self)
      @station_position += 1
    else
      puts 'Поезд уже прибыл на конечную станцию'
    end
  end

  def move_back_station
    if @station_position > 0
      current_station.send_train(self)
      previous_station.receive_train(self)
      @station_position -= 1
    else
      puts 'Поезд уже прибыл на начальную станцию'
    end
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
