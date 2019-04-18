# тестирование работы всех классов

require '../station.rb'
require '../route.rb'
require '../train.rb'

first_station = Station.new('Фрязево')
end_station = Station.new('Москва-Курская')
route1 = Route.new(first_station, end_station)
['Электроугли', 'Железнодорожный', 'Новогиреево'].each.with_index(1) { |station, position| route1.add_station(Station.new(station), position) }

puts "\nПроверим, есть ли поезда на начальной станции"
first_station.trains.each { |train| puts "Номер поезда: #{train.number}" }

train1 = Train.new("П6796", "пассажирский", 12)
puts "\nПринять маршрут"
train1.receive_route(route1)

puts "\nПроверим, есть ли поезд на начальной станции"
first_station.trains.each { |train| puts "Номер поезда: #{train.number}" }

puts "\nОтправляем поезд по маршруту: по всем станциям от начальной до конечной"
route1.stations.each do |station|
  previous_station = train1.previous_station
  next_station = train1.next_station
  # если станция начальная previous_station = 'нет'
  previous_station ? previous_station = train1.previous_station.name : previous_station = 'нет'
  # если станция конечная next_station = 'нет'
  next_station ? next_station = train1.next_station.name : next_station = 'нет'
  puts "Поезд #{train1.number}: Предыдущая станция: #{previous_station} Текущая: #{train1.current_station.name} Следующая: #{next_station}"
  train1.move_next_station
end

puts "Переместим поезд на 2 станции назад"
train1.move_back_station
train1.move_back_station
