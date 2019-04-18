# класс Станция
class Station
  # список всех поездов возвращается через переменную trains
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
    puts "Станция #{@name} - Поезд #{train.number} прибыл"
  end

  # REVIEW: если я правильно понял, нужно вернуть поезда определенного типа и их количество
  # "Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских"
  def show_trains_by_type(train_type)
    trains_by_type = @trains.select { |train| train if train.type == train_type }
    [trains_by_type, trains_by_type.size]
  end

  def send_train(train)
    @trains.delete(train)
    puts "Станция #{@name} - Поезд #{train.number} отправлен"
  end

end

# класс Маршрут
class Route

  attr_reader :stations

  def initialize(first_station, end_station)
    @stations = [first_station, end_station]
  end

  def add_station(station, position)
    if position != 0 && position != @stations.size
      @stations.insert(position, station)
    else
      puts 'Можно добавить только промежуточную станцию'
    end
  end

  def delete_station(station_name)
    if station_name != @stations.first.name && station_name != @stations.last.name
      @stations.each { |station| @stations.delete(station) if station.name == station_name }
    else
      puts 'Можно удалить только промежуточную станцию'
    end
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end

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
      @route.stations[@station_position].send_train(self)
      @station_position += 1
      @route.stations[@station_position].receive_train(self)
    else
      puts 'Поезд уже прибыл на конечную станцию'
    end
  end

  def move_back_station
    if @station_position > 0
      @route.stations[@station_position].send_train(self)
      @station_position -= 1
      @route.stations[@station_position].receive_train(self)
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
