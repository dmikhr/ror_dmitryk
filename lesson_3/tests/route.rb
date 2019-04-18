# тестирование работы классов

require '../task_oop.rb'

first_station = Station.new('Фрязево')
end_station = Station.new('Москва-Курская')
route1 = Route.new(first_station, end_station)
route1.show_stations
['Электроугли', 'Железнодорожный', 'Новогиреево'].each.with_index(1) { |station, position| route1.add_station(Station.new(station), position) }
puts "\nС новыми станциями"
route1.show_stations

puts "\nУдалим станцию Железнодорожный"
route1.delete_station('Железнодорожный')
puts "Список станций"
route1.show_stations

puts "\nПопробуем удалить начальную станцию"
route1.delete_station('Фрязево')
puts 'Список станций'
route1.show_stations

puts "\nДобавим станцию в середину маршрута"
route1.add_station(Station.new('Купавна'), 2)
route1.show_stations

puts "\nПопытаемся поменять начальную станцию"
route1.add_station(Station.new('Орехово-Зуево'), 0)
route1.show_stations

puts "\nПопытаемся поменять конечную станцию"
route1.add_station(Station.new('Москва-Рижская'), 5)
route1.show_stations
