require_relative 'instancecounter'
require_relative 'production_company'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

station = Station.new('Бологое')
station2 = Station.new('Тверь')
station3 = Station.new('Санкт-Петербург')

puts "Все объекты класса Station: #{Station.all}"

# создадим вагоны
carriages_seed = {'ВП1000' => 1, 'ВП1100' => 1, 'ВП1200' => 1, 'ВГ9000' => 2, 'ВГ9200' => 2}
carriages = []

carriages_seed.each do |id, type|
  case type
  when 1
    carriages << PassengerCarriage.new(id)
  when 2
    carriages << CargoCarriage.new(id)
  end
end

puts "\nВагоны"
puts carriages.inspect
# ===
# создадим поезда
trains_seed = {'ВП6000' => 'пассажирский', 'ВП6100'=> 'пассажирский', 'ВП6200' => 'пассажирский', 'ВП6300' => 'пассажирский', 'ВГ1000'=> 'грузовой', 'ВГ1100' => 'грузовой', 'ВГ1200'=> 'грузовой'}
trains = []
trains_seed.each do |number, type|
  case type
  when 'пассажирский'
    trains << PassengerTrain.new(number)
  when 'грузовой'
    trains << CargoTrain.new(number)
  end
end
puts "\nПоезда"
puts trains.inspect
# зададим название производителя поездов
trains.each { |train| train.production_company_name = 'ПоездСтрой' }

puts "\nВыведем производителя поезда"
puts "Поезд #{trains[0].number} сделан компанией #{trains[0].production_company_name}"

# зададим название производителя вагонов
carriages.each { |carriage| carriage.production_company_name = 'ВагонСтрой' }
puts "\nВыведем производителя вагона"
puts "Вагон #{carriages[0].id} сделан компанией #{carriages[0].production_company_name}"

puts trains.inspect

puts "\nИщем существующий поезд"
res = Train.find('ВП6100')
puts res.inspect


puts "\nИщем несуществующий поезд"
res = Train.find('11122222')
puts res.inspect
