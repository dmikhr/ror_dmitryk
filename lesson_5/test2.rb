require_relative 'instancecounter'
require_relative 'production_company'
require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'

station1 = Station.new('Бологое')
station2 = Station.new('Тверь')
station3 = Station.new('Санкт-Петербург')

train1 = Train.new('ВП1000', 'пассажирский')
train2 = Train.new('ВГ2000', 'грузовой')

trainpassenger1 = PassengerTrain.new('ВП3333')
traincargo1 = CargoTrain.new('ВГ0001')
traincargo2 = CargoTrain.new('ВГ0002')

route1 = Route.new(station1, station3)

puts "Количество объектов Station: #{Station.instances}"
puts "Количество объектов Train: #{Train.instances}"
puts "Количество объектов Route: #{Route.instances}"

puts "\nКоличество инстансов подклассов Train: PassengerTrain, CargoTrain"
puts "Количество объектов PassengerTrain: #{PassengerTrain.instances}"
puts "Количество объектов CargoTrain: #{CargoTrain.instances}"
