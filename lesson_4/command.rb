# класс Command содержит набор методов, реализующих команды, доступные в меню программы
# также в экземпляре этого класса будут храниться созданные объекты - поезда/маршруты/вагоны/станции
# в методах заданы значения по умолчанию, т.к. в подклассе CommandPrompt данные будут поступать от пользователя и методы будут вызываться без аргументов
class Command
  attr_reader :trains, :routes, :stations, :free_carriages
  def initialize
    @trains = []
    @routes = []
    @stations = []
    # здесь будут храниться только свободные вагоны, не прицепленные к поездам
    # чтобы исключить ситуацию, когда один вагон будет прицеплен к двум поездам одновременно
    @free_carriages = []
    seed
  end

  # генерируем вагоны
  def seed
    # хеш с вагонами, формат id_вагона => тип вагона (1 - пассажирский, 2 - грузовой)
    carriages = {'ВП1000' => 1, 'ВП1100' => 1, 'ВП1200' => 1, 'ВГ9000' => 2, 'ВГ9200' => 2}
    carriages.each { |id, type| create_carriage(type, id) }
  end

  def create_station(station_name = '')
    @stations << Station.new(station_name)
    puts 'Станция создана'
  end

  # 1 - пассажирский, 2 - грузовой
  def create_train(type = '', number = '')
    case type.to_i
    when 1
      @trains << PassengerTrain.new(number)
    when 2
      @trains << CargoTrain.new(number)
    end
  end

  def create_route(first_station = '', end_station = '')
    @routes << Route.new(get_station_by_name(first_station), get_station_by_name(end_station))
  end

  def add_station_to_route(route_id = '', station_id = '', station_position = '')
    @routes[route_id.to_i - 1].add_station(@stations[station_id.to_i - 1], station_position.to_i)
  end

  def remove_station_from_route(route_id = '', station_id = '')
    @routes[route_id.to_i - 1].delete_station(@stations[station_id.to_i - 1])
  end

  def set_route(route_id = '', train_number = '')
    train = get_train_by_number(train_number)
    train.receive_route(@routes[route_id.to_i - 1])
  end

  def add_carriage(number = '', carriage_id = '')
    train = get_train_by_number(number)
    carriage = get_carriage_by_id(carriage_id)
    if train.add_carriage(carriage)
      # вагон прицеплен к поезду, удалем его из списка свободных вагонов
      @free_carriages.delete(carriage)
    end
  end

  def remove_carriage(number = '', carriage_id = '')
    # нужно работать с поездом из вассива, а не с копией
    train = get_train_by_number(number)
    puts "Вагоны, прицепленные к поезду #{number}"
    puts show_train_carriages(train)
    carriage = get_train_carriage_by_id(train, carriage_id)
    train.remove_carriage(carriage)
    # т.к. вагон отцеплен, добавляем его в список свободных вагонов
    @free_carriages << carriage
  end

  def move_train(number = '', direction = '')
    train = get_train_by_number(number)
    # для передвижения зададим скорость поезду
    train.speed_up(30)
    # "Направление движения: 1 - вперед, 2 - назад"
    case direction.to_i
    when 1
      train.move_next_station
    when 2
      train.move_back_station
    end
    # останавливаем поезд по прибытию на станцию
    train.slow_down(30)
  end

  def trains_on_station(station_name = '')
    puts "Поезда на станции #{station_name}"
    station =  get_station_by_name(station_name)
    station.trains.each { |train| puts train.number }
  end

  def show_available_stations
    @stations.each.with_index(1) { |station, id| puts "#{id} - #{station.name}" }
  end

  protected
  # вспомогательные методы
  # недоступны в интерфейсе класса
  # используются исключительно методами внутри класса Command и подклассом CommandPrompt

  # используется внутри класса в seed методе
  def create_carriage(type, id)
    case type
    when 1
      @free_carriages << PassengerCarriage.new(id)
    when 2
      @free_carriages << CargoCarriage.new(id)
    end
    #puts "Вагон #{id} создан"
  end

  def get_train_by_number(number)
    @trains.select { |train| train.number == number }[0]
  end

  def get_station_by_name(name)
    @stations.select { |station| station.name == name }[0]
  end

  # найти свободный вагон по id
  def get_carriage_by_id(id)
    @free_carriages.select { |carriage| carriage.id == id }[0]
  end

  # найти вагон прицепленный к поезду train
  def get_train_carriage_by_id(train, carriage_id)
    train.carriages.select { |carriage| carriage.id == carriage_id }[0]
  end

  def show_train_carriages(train)
    train.carriages.each.with_index(1) { |carriage, id| puts "#{id} - Вагон #{carriage.id}" }
  end
end
