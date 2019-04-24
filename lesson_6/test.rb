require_relative 'validation.rb'
require_relative 'instance_counter.rb'
require_relative 'production_company.rb'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

puts 'Создание станций'
station1 = Station.new('Бологое')
station2 = Station.new('Тверь')
station3 = Station.new('Санкт-Петербург')
puts station3.valid?
#station4 = Station.new('')
#station5 = Station.new(station2)

puts 'Создание маршрута'
puts 'Корректное'
route1 = Route.new(station1, station3)
puts route1.valid?

#puts 'Попробуем задать конечную станцию строкой'
#route1 = Route.new(station1, 'Солнечногорск')
#puts route1.class

#puts 'Попробуем задать начальную и конечную станцию одну и ту же'
#route1 = Route.new(station1, station1)
#puts route1.class

carriage1 = Carriage.new('В100', 'пассажирский')
carriage2 = Carriage.new('В110', 'грузовой')
puts carriage2.valid?
#p carriage1
#carriage3 = Carriage.new('В110', 'цистерна')
#p carriage3
#carriage4 = Carriage.new(route1, 'пассажирский')
#carriage4 = Carriage.new('', 'пассажирский')

train1 = Train.new('S1000', 'грузовой')
train2 = Train.new('Aqw-01', 'пассажирский')
train3 = Train.new('ВЛ1-01', 'грузовой')
puts train3.valid?
#train4 = Train.new('ВЛЦ1-01', 'грузовой')
#train1 = Train.new('Aqw-010_', 'грузовой')
#train1 = Train.new('', 'грузовой')
#train1 = Train.new(carriage1, 'грузовой')
#train1 = Train.new('adw-01', 'локомотив')

puts "\nПроверяем, унаследовался ли метод проверки в подклассах Train"
ctrain1 = CargoTrain.new('S1000')
#ctrain1 = CargoTrain.new('S1000www')
puts ctrain1.valid?

ptrain1 = PassengerTrain.new('P10-00')
#ptrain1 = PassengerTrain.new('P10--00')
puts ptrain1.valid?

puts "\nПроверяем, унаследовался ли метод проверки в подклассах Carriage"
ccargo = CargoCarriage.new('В100')
#ccargo = CargoCarriage.new('')
puts ccargo.valid?

pcargo = PassengerCarriage.new('В110')
#pcargo = PassengerCarriage.new('')
puts pcargo.valid?
