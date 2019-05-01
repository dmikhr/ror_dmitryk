require_relative 'production_company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
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

def debug_data(cmd_obj)
  puts 'DEBUG: Trains'
  p cmd_obj.trains
  puts 'DEBUG: Stations'
  p cmd_obj.stations
  puts 'DEBUG: Routes'
  p cmd_obj.routes
end

pcar = PassengerCarriage.new('ВГ100', 60)
p pcar

pcar.reserve_seat
pcar.reserve_seat
pcar.reserve_seat
p pcar

puts pcar.reserved_seats
puts pcar.show_free_seats

puts '-----'

ccar = CargoCarriage.new('ВГ900', 1000)
p ccar

ccar.reserve_volume(100)
p ccar
ccar.reserve_volume(250)
p ccar

puts ccar.show_free_volume

puts '-----'
station1 = Station.new('Бологое')
Station.new('Тверь')

train1 = Train.new('S1000', 'грузовой')
train2 = Train.new('ПВЛ-99', 'пассажирский')
train3 = Train.new('ВЛ1-01', 'грузовой')

# примем поезда на станции
[train1, train2, train3].map { |train| station1.receive_train(train) }
# puts station1.trains

puts 'блок выводит номера поездов на заданной станции'
station1.each_train do |train|
  puts "Поезд #{train.number} на станции #{station1.name}"
end

# проверяем поведение функции при вызове без аргумента
# учитывая, что в Station есть проверка if block_given?
# вызов без аргумента не должен привести к ошибке,
# а будет возвращен nil
puts 'вызов без аргументов'
p station1.each_train
puts 'все названия поездов заглавными буквами'
station1.each_train { |train| puts "Поезд #{train.number.upcase}" }

puts "\nПоезда и вагоны"
carr1 = PassengerCarriage.new('ВП1000', 60)
carr2 = PassengerCarriage.new('ВП2000', 60)
carr3 = PassengerCarriage.new('ВП3000', 40)
carr4 = PassengerCarriage.new('ВП4000', 40)

[carr1, carr2, carr3, carr4].map { |carr| train2.add_carriage(carr) }
p train2

puts 'блок выводящий вагоны, прицепленные к заданному поезду'
train2.each_carriage { |carriage| puts carriage.id }

puts 'блок выводящий вагоны, прицепленные к заданному поезду - с сообщением'
train2.each_carriage do |carriage|
  puts "Вагон #{carriage.id} прицеплен к поезду #{train2.number}"
end

puts 'вызов без аргументов'
p train2.each_carriage

puts "\nТестирование интерфейса"
cmd = Command.new
cmd.create_carriage('1111', 1, 60)
p cmd.carriages

cmd.create_carriage('2222', 1, 40)
cmd.create_carriage('0101', 2, 9000)
cmd.create_carriage('9090', 2, 10_000)
p cmd.carriages

# train_carriages_list
cmd.create_train(1, 'ПВЛ-99')

cmd.create_train(2, 'ГВЛ-11')

cmd.train_carriages_list('ПВЛ-99')
cmd.add_carriage('ПВЛ-99', '1111')
cmd.add_carriage('ПВЛ-99', '2222')
# пробуем присоединить грузовой вагон к пассадирскому поезду
# cmd.add_carriage('ПВЛ-99', '0101')
cmd.train_carriages_list('ПВЛ-99')

cmd.add_carriage('ГВЛ-11', '0101')
cmd.add_carriage('ГВЛ-11', '9090')
cmd.train_carriages_list('ГВЛ-11')

# trains_on_station
cmd.create_station('Бологое')
cmd.create_station('Тверь')
cmd.create_station('СПБ')

puts cmd.stations[0].class

cmd.create_route('Тверь', 'СПБ')
cmd.set_route(1, 'ПВЛ-99')
# должен отобразиться ПВЛ-99, тк ему назначен маршур из Твери и
# он должен был быть принят начальной станцией
cmd.trains_on_station('Тверь')

# reserve_seat
# резервируем места
cmd.reserve_seat('2222')
cmd.reserve_seat('2222')
cmd.reserve_seat('1111')

# reserve_volume
cmd.reserve_volume('0101', 100)
cmd.reserve_volume('0101', 225)

# проверим как поменялись объекты вагоны
p cmd.carriages
