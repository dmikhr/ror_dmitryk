# класс Command содержит набор методов, реализующих команды, доступные в меню программы
# также в экземпляре этого класса будут храниться созданные объекты - поезда/маршруты/вагоны/станции
# в методах заданы значения по умолчанию, т.к. в подклассе CommandPrompt данные будут поступать от пользователя и методы будут вызываться без аргументов
class Command
  attr_reader :trains, :routes, :stations, :carriages
  def initialize
    @trains = []
    @routes = []
    @stations = []
    @carriages = []
    #seed
  end

  # генерируем вагоны
  def seed
    # хеш с вагонами, формат id_вагона => тип вагона (1 - пассажирский, 2 - грузовой)
    #carriages = {'ВП1000' => 1, 'ВП1100' => 1, 'ВП1200' => 1, 'ВГ9000' => 2, 'ВГ9200' => 2}
    #carriages.each { |id, type| create_carriage(type, id, type == 1 ? 60 : 1000) }
    p @carriages
  end

  def move_train_to_station(train_number, station_name)
    train = get_train_by_number(train_number)
    station = get_station_by_name(station_name)
    station.receive_train(train)
  end

  def create_carriage(id = '', type = '', param = '')
    case type.to_i
    when 1
      # количество мест - целое число
      @carriages << PassengerCarriage.new(id, param.to_i)
    when 2
      # объем может быть float
      @carriages << CargoCarriage.new(id,param.to_f)
    end
  end

  def train_carriages_list(train_number = '')
    train = get_train_by_number(train_number)
    if train.carriages.size > 0
      case train.type
      when 'пассажирский'
        train.block_carriage { |carriage| puts "Пассажирский вагон номер: #{carriage.id}, мест: #{carriage.seats_num}, свободных: #{carriage.show_free_seats}, занятых: #{carriage.reserved_seats}" }
      when 'грузовой'
        train.block_carriage { |carriage| puts "Грузовой вагон номер: #{carriage.id}, объем: #{carriage.volume}, осталось: #{carriage.show_free_volume}, занято: #{carriage.reserved_volume}" }
      end
    else
      puts 'У поезда вагонов нет'
    end
  end

  def trains_on_station(station_name = '')
    station = get_station_by_name(station_name)
    station.block_train { |train| train }
  end

  def reserve_seat(carriage_id = '')
    carriage = get_carriage_by_id(carriage_id)
    carriage.reserve_seat
  end

  def reserve_volume(carriage_id = '', volume = '')
    carriage = get_carriage_by_id(carriage_id)
    carriage.reserve_volume(volume.to_f)
  end

  def create_station(station_name = '')
    @stations << Station.new(station_name)
    puts 'Станция создана'
  end

  # 1 - пассажирский, 2 - грузовой
  def create_train(type = '', number = '')
    begin
      case type.to_i
      when 1
        @trains << PassengerTrain.new(number)
      when 2
        @trains << CargoTrain.new(number)
      end
    rescue Exception => e
      puts "Ошибка, повторите ввод. Причина: #{e.message}"
    end
  end

  def create_route(first_station = '', end_station = '')
    @routes << Route.new(get_station_by_name(first_station), get_station_by_name(end_station))
  end

  def add_station_to_route(route_id = '', station_id = '', station_position = '')
    puts 'Можно добавить только промежуточную станцию' unless @routes[route_id.to_i - 1].add_station(@stations[station_id.to_i - 1], station_position.to_i)
  end

  def remove_station_from_route(route_id = '', station_id = '')
    puts 'Можно удалить только промежуточную станцию' unless @routes[route_id.to_i - 1].delete_station(@stations[station_id.to_i - 1])
  end

  def set_route(route_id = '', train_number = '')
    train = get_train_by_number(train_number)
    train.receive_route(@routes[route_id.to_i - 1])
  end

  def add_carriage(number = '', carriage_id = '')
    train = get_train_by_number(number)
    carriage = get_carriage_by_id(carriage_id)
    puts 'Проверьте, что поезд не движется и вагон соответствует типу поезда' unless train.add_carriage(carriage)
  end

  def remove_carriage(number = '', carriage_id = '')
    # нужно работать с поездом из вассива, а не с копией
    train = get_train_by_number(number)
    puts "Вагоны, прицепленные к поезду #{number}"
    puts show_train_carriages(train)
    carriage = get_train_carriage_by_id(train, carriage_id)
    puts 'Проверьте, что поезд не движется и у него еще есть вагоны' unless train.remove_carriage(carriage)
  end

  def move_train(number = '', direction = '')
    train = get_train_by_number(number)
    # для передвижения зададим скорость поезду
    train.speed_up(30)
    # "Направление движения: 1 - вперед, 2 - назад"
    case direction.to_i
    when 1
      train_moving_forward(train)
    when 2
      train_moving_back(train)
    end
    # останавливаем поезд по прибытию на станцию
    puts 'Скорость не может быть меньше 0' unless train.slow_down(30)
  end

  def show_available_stations
    @stations.each.with_index(1) { |station, id| puts "#{id} - #{station.name}" }
  end

  protected

  def get_train_by_number(number)
    @trains.select { |train| train.number == number }[0]
  end

  def get_station_by_name(name)
    @stations.select { |station| station.name == name }[0]
  end

  # найти свободный вагон по id
  def get_carriage_by_id(id)
    @carriages.select { |carriage| carriage.id == id }[0]
  end

  # найти вагон прицепленный к поезду train
  def get_train_carriage_by_id(train, carriage_id)
    train.carriages.select { |carriage| carriage.id == carriage_id }[0]
  end

  def show_train_carriages(train)
    train.carriages.each.with_index(1) { |carriage, id| puts "#{id} - Вагон #{carriage.id}" }
  end

  # вспомогательные функции для отображения движения поезда по станциям
  # заменяют puts из класса Station
  def train_moving_forward(train)
    station = find_train(train)
    puts "Поезд #{train.number} на станции #{station.name}"
    puts "Поезд #{train.number} уже прибыл на конечную станцию #{station.name}" unless train.move_next_station
  end

  def train_moving_back(train)
    station = find_train(train)
    puts "Поезд #{train.number} на станции #{station.name}"
    puts "Поезд #{train.number} уже прибыл на начальную станцию #{station.name}" unless train.move_back_station
  end

  # на какой станции сейчас поезд
  def find_train(train)
    @stations.select { |station| station.trains.include?(train) }[0]
  end

end
