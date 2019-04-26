require_relative 'production_company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'command'
require_relative 'commandprompt'

cmd = Command.new

test_stations = ['Бологое', 'Тверь', 'Москва', 'Санкт-Петербург']
# генерируем пассажирские вагоны
(1..15).each { |i| cmd.create_carriage("ВП-#{i}", 1, 60) }
# генерируем грузовые вагоны
(1..15).each { |i| cmd.create_carriage("ВГ-#{i}", 2, 2000) }

# зарезервируем места в первых 10 рассажирских вагонах
(1..10).each do |i|
  # по i + 1 места в каждом
  (i+1).times { cmd.reserve_seat("ВП-#{i}") }
end

# зарезервируем объем в заданных грузовых вагонах
[1, 2, 5, 7, 10].each { |i| cmd.reserve_volume("ВГ-#{i}", i*100) }


#p cmd.free_carriages

# создаем станции
test_stations.each { |station_name| cmd.create_station(station_name) }
#p cmd.stations

test_trains = {'ПВЛ-99' => {type: 1, station: 'Бологое', carriages: (1..3)}, 'ПВЛ-01' => {type: 1, station: 'Тверь', carriages: (4..10)}, 'Г01-01' => {type: 2, station: 'Тверь', carriages: (1..5)}, 'Г01-02' => {type: 2, station: 'Москва', carriages: (6..12)}, 'Г11-11' => {type: 2, station: 'Москва', carriages: 0}}

test_trains.each do |train_name, data|
  cmd.create_train(data[:type], train_name)
  if test_trains[train_name][:carriages] != 0
    test_trains[train_name][:carriages].each { |i| cmd.add_carriage(train_name, data[:type] == 1 ? "ВП-#{i}" : "ВГ-#{i}") }
  end
  cmd.move_train_to_station(train_name, data[:station])
end

cmd.stations.each do |station|
  #puts "Поезда на станции #{station.name}"
  puts '----------'
  puts "Станция #{station.name}"
  trains = cmd.trains_on_station(station.name)
  #p trains
  trains.each do |train|
    #puts "Поезд #{train.number}"
    puts "Поезд #{train.number}, тип: #{train.type}, количество вагонов: #{train.carriages.size}"
    puts "Вагоны:"
    cmd.train_carriages_list(train.number)
  end
end
