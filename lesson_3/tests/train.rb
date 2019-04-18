# тестирование работы классов

require '../task_oop.rb'

first_station = Station.new('Фрязево')
end_station = Station.new('Москва-Курская')
route1 = Route.new(first_station, end_station)
['Электроугли', 'Железнодорожный', 'Новогиреево'].each.with_index(1) { |station, position| route1.add_station(Station.new(station), position) }

train1 = Train.new('П6796', 'пассажирский', 12)
train2 = Train.new('П6915', 'пассажирский', 10)
train3 = Train.new('Г1105', 'грузовой', 35)

puts 'Грузовой поезд'
puts "Скорость: #{train3.speed}"
train3.speed_up(1)
puts "Скорость: #{train3.speed}"
train3.speed_up(15)
puts "Скорость: #{train3.speed}"
puts 'Пробуем прицепить вагон на ходу'
train3.add_carriage
puts 'Пробуем снизить скорость меньше 0'
train3.slow_down(20)
puts "Скорость: #{train3.speed}"
puts 'Останавливаем поезд'
train3.slow_down(16)
puts "Скорость: #{train3.speed}"
puts 'Прицепляем вагон'
puts "Было вагонов: #{train3.carriage_num}"
train3.add_carriage
puts "Стало вагонов: #{train3.carriage_num}"

puts "\nПассажирский поезд"
puts "Скорость: #{train1.speed}"
puts 'Отцепляем 2 вагона последовательно'
puts "Было вагонов: #{train1.carriage_num}"
train1.remove_carriage
train1.remove_carriage
puts "Сталов вагонов: #{train1.carriage_num}"
