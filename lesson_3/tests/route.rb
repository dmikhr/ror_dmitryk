# тестирование работы класса Route

require '../station.rb'
require '../route.rb'
require '../train.rb'

first_station = Station.new('Фрязево')
end_station = Station.new('Москва-Курская')
route1 = Route.new(first_station, end_station)
route1.show_stations
way_stations = []
['Электроугли', 'Железнодорожный', 'Новогиреево'].each.with_index(0) { |station, position| way_stations.insert(position, Station.new(station)) }
way_stations.each.with_index(1) { |station, position| route1.add_station(station, position) }

puts "\nС новыми станциями"
route1.show_stations

puts "\nУдалим станцию Железнодорожный"
route1.delete_station(way_stations[1])
puts "Список станций"
route1.show_stations

puts "\nПопробуем удалить начальную станцию"
route1.delete_station(first_station)
puts 'Список станций'
route1.show_stations

puts "\nДобавим станцию в середину маршрута"
route1.add_station(Station.new('Купавна'), 2)
route1.show_stations

puts "\nПопытаемся поменять начальную станцию"
route1.add_station(Station.new('Орехово-Зуево'), 0)
route1.show_stations

puts "\nПопытаемся поставить станцию за начальной"
route1.add_station(Station.new('Орехово-Зуево'), -1)
route1.show_stations

puts "\nПопытаемся поменять конечную станцию"
route1.add_station(Station.new('Москва-Рижская'), 5)
route1.show_stations

puts "\nПопытаемся поставить станцию за конечной"
route1.add_station(Station.new('Москва-Рижская'), 20)
route1.show_stations
