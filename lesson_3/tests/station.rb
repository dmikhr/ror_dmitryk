# тестирование работы класса Station

require '../station.rb'
require '../route.rb'
require '../train.rb'

test_station = Station.new('Фрязево')
train1 = Train.new('П6796', 'пассажирский', 12)
train2 = Train.new('П6915', 'пассажирский', 10)
train3 = Train.new('Г1105', 'грузовой', 35)

puts "\n3 поезда прибыли на станцию"
test_station.receive_train(train1)
test_station.receive_train(train2)
test_station.receive_train(train3)

test_station.trains.each { |train| puts "Номер поезда: #{train.number}" }

puts "\nПокажем только грузовые поезда"
test_station.show_trains_by_type('грузовой').each { |train| puts "Грузовой поезд: #{train.number}" }
puts "Количество грузовых поездов: #{test_station.show_trains_by_type('грузовой').size}"

puts "\nПокажем только пассажирские поезда"
test_station.show_trains_by_type('пассажирский').each { |train| puts "Пассажирский поезд: #{train.number}" }
puts "Количество пассажирских поездов: #{test_station.show_trains_by_type('пассажирский').size}"

puts "\nОтправим поезд П6796"
test_station.send_train(train1)
puts "\nПоезда на станции:"
test_station.trains.each { |train| puts "Номер поезда: #{train.number}" }
