require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'command'

cmd = Command.new

puts "Создание станций"
puts 'Создаем станцию Коломна'
cmd.create_station('Коломна')

puts 'Создаем станцию Москва'
cmd.create_station('Москва')

puts 'Создаем станцию Вешняки'
cmd.create_station('Вешняки')

puts 'Создаем станцию Косино'
cmd.create_station('Косино')

#puts cmd.stations.inspect

#puts cmd.get_station_by_name('Коломна').inspect

# =====
puts "Создание поездов"
puts 'Пассажирский'
cmd.create_train(1, 'П6755')

puts '2-ой пассажирский'
cmd.create_train(1, 'П6100')

puts 'Грузовой'
cmd.create_train(2, 'Г1200')

puts '2-ой грузовой'
cmd.create_train(2, 'Г1020')

puts cmd.trains.inspect

# =====
puts 'Список всех станций'
cmd.show_available_stations

puts 'Маршруты'
puts 'Создаем маршрут Москва -> Коломна'
cmd.create_route('Москва', 'Коломна')
puts cmd.routes.inspect

puts 'Добавим промежуточную станциию Вешняки'
cmd.add_station_to_route(1, 3, 1)

puts 'Добавим промежуточную станциию Косино'
cmd.add_station_to_route(1, 4, 2)
puts cmd.routes.inspect

puts 'Удалим промежуточную станциию Косино'
cmd.remove_station_from_route(1, 4)
puts cmd.routes.inspect

# =====
puts 'Прицепим вагоны к пассажирскому поезду'
cmd.add_carriage('П6100', 'ВП1100')
cmd.add_carriage('П6100', 'ВП1200')
puts 'Пробуем прицепить грузовой вагон к пассажирскому поезду'
cmd.add_carriage('П6100', 'ВГ9000')
puts cmd.trains.inspect

puts 'Отцепляем вагон'
puts 'До отцепления'
puts cmd.trains.inspect
cmd.remove_carriage('П6100', 'ВП1200')
puts 'После отцепления'
puts cmd.trains.inspect

puts 'Прицепим вагоны к грузовому поезду'
cmd.add_carriage('Г1200', 'ВГ9000')
puts 'Пробуем прицепить пассажирский вагон к грузовому поезду'
cmd.add_carriage('Г1200', 'ВП1000')
puts cmd.free_carriages.inspect
puts cmd.trains.inspect

# =====
puts 'Назначим маршрут поезду'
cmd.set_route(1, 'П6100')
puts cmd.routes.inspect

puts 'Отправим поезд по маршруту вперед'
cmd.move_train('П6100', 1)
cmd.move_train('П6100', 1)
cmd.move_train('П6100', 1)


puts 'Отправим поезд по маршруту назад'
cmd.move_train('П6100', 2)
cmd.move_train('П6100', 2)
cmd.move_train('П6100', 2)

puts 'Отправим поезд по маршруту вперед на 1 станцию'
cmd.move_train('П6100', 1)

puts 'Посмотрим поезда на станциях'
puts 'Вешняки'
cmd.trains_on_station('Вешняки')

puts 'Посмотрим поезда на станциях'
puts 'Коломна'
cmd.trains_on_station('Коломна')
