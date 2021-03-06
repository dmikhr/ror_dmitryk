# класс CommandPrompt является подклассом класса Command
# здесь в методах добавлен пользовательский ввод, этот класс используется в меню программы
# таким образом разделяется пользовательский ввод и логика работы соответствующих методов
# в классе CommandPrompt реализуется ввод, а обработка происходит через super() в методе родительского класса
# также родительский класс Command, за счет отсутствия пользовательского ввода, можно использовать для автоматического тестирования методов (test.rb)
class CommandPrompt < Command
  attr_reader :commands

  def initialize
    # команды задаюстся в виде 2-х мерного массива, парами название_команды - метод
    @commands = [
      ['Создать станцию', method(:create_station)], ['Создать поезд', method(:create_train)], ['Создать маршрут', method(:create_route)],
      ['Добавить станцию в маршрут', method(:add_station_to_route)], ['Удалить станцию из маршрута', method(:remove_station_from_route)],
      ['Назначить маршрут поезду',method(:set_route)], ['Прицепить вагон к поезду', method(:add_carriage)],
      ['Отцепить вагон от поезда', method(:remove_carriage)], ['Переместить поезд по маршруту', method(:move_train)],
      ['Список станций', method(:show_available_stations)], ['Cписок поездов на станции', method(:trains_on_station)],
      ['Список вагонов у поезда', method(:train_carriages_list)], ['Зарезервировать место в пассажирском вагоне', method(:reserve_seat)],
      ['Зарезервировать объем в грузовом вагоне', method(:reserve_volume)], ['Создать вагон', method(:create_carriage)]
    ]
    super
  end

  # выводим доступные команды из массива @commands
  # вывод в цикле может быть удобнее по сравнению с case/when в случае необходимости добавления новых команд или изменения порядка их вывода
  def show_options
    puts "Доступные команды:"
    @commands.each.with_index(1) {|command, index| puts "#{index} - #{command[0]}"}
  end

  def train_carriages_list(train_number = '', type = '')
    puts 'Введите номер поезда'
    train_number = gets.chomp
    super(train_number)
  end

  def create_carriage(id = '', type = '', param = '')
    puts 'Введите номер вагона'
    id = gets.chomp
    puts 'Введите тип вагона: 1 - пассажирский, 2  - грузовой'
    type = gets.chomp
    case type.to_i
    when 1
      puts 'Введите количество мест в вагоне'
      param = gets.chomp
    when 2
      puts 'Введите объем вагона'
      param = gets.chomp
    end
    super(id, type, param)
  end

  def trains_on_station(station_name = '')
    puts 'Введите название станции'
    station_name = gets.chomp
    station = get_station_by_name(station_name)
    station.block_train do |train|
      puts "Поезд #{train.number}, "/
      "тип: #{train.type}, "\
      "количество вагонов: #{train.carriages.size}"
    end
  end

  def reserve_seat(carriage_id = '')
    puts 'Введите номер пассажирского вагона в котором нужно зарезервировать место'
    carriage_id = gets.chomp
    super(carriage_id)
    puts "Место зарезервировано в вагоне #{carriage_id}"
  end

  def reserve_volume(carriage_id = '', volume = '')
    puts 'Введите номер грузового вагона в котором нужно зарезервировать объем'
    carriage_id = gets.chomp
    puts 'Введите объем'
    volume = gets.chomp
    super(carriage_id, volume)
    puts "Объем #{volume} зарезервирован в вагоне #{carriage_id}"
  end

  def create_station(station_name = '')
    puts 'Введите название станции'
    station_name = gets.chomp
    super(station_name)
  end

  def create_train(type = '', number = '')
    puts 'Введите тип поезда: 1 - пассажирский, 2  - грузовой'
    type = gets.chomp
    puts 'Введите номер поезда'
    number = gets.chomp
    super(type, number)
  end

  def create_route(first_station = '', end_station = '')
    puts 'Введите начальную станцию маршрута'
    first_station = gets.chomp
    puts 'Введите конечную станцию маршрута'
    end_station = gets.chomp
    super(first_station, end_station)
  end

  def add_station_to_route(route_id = '', station_id = '', station_position = '')
    puts 'Доступны маршруты:'
    show_available_routes
    puts 'Введите номер маршрута'
    route_id = gets.chomp
    puts 'Введите номер станции'
    station_id = gets.chomp
    puts 'Введите позицию станции'
    station_position = gets.chomp
    super(route_id, station_id, station_position)
  end

  def remove_station_from_route(route_id = '', station_id = '')
    puts 'Доступны маршруты:'
    show_available_routes
    puts 'Из какого маршрута удалить станцию?'
    route_id = gets.chomp
    puts 'Номер станции для удаления'
    station_id = gets.chomp
    super(route_id, station_id)
  end

  def set_route(route_id = '', train_number = '')
    puts 'Номер маршрута'
    route_id = gets.chomp
    puts 'Номер поезда'
    train_number = gets.chomp
    super(route_id, train_number)
  end

  def add_carriage(number = '', carriage_id = '')
    puts 'Номер поезда к которому нужно добавить вагон'
    number = gets.chomp
    puts 'id прицепляемого вагона'
    carriage_id = gets.chomp
    super(number, carriage_id)
  end

  def remove_carriage(number = '', carriage_id = '')
    puts 'Номер поезда от которого нужно отцепить вагон'
    number = gets.chomp
    puts 'id отцепляемого вагона'
    carriage_id = gets.chomp
    super(number, carriage_id)
  end

  def move_train(number = '', direction = '')
    puts 'Номер поезда который нужно переместить'
    number = gets.chomp
    puts 'Выберите направление движения: 1 - вперед, 2 - назад'
    direction = gets.chomp
    super(number, direction)
  end

end
