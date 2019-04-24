require_relative 'validation.rb'
require_relative 'instance_counter.rb'
require_relative 'production_company.rb'
require_relative 'train'

puts 'Для выхода введитие "выход"'

trains = {}

loop do
  puts 'Введите номер поезда'
  puts 'Формат: три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса'
  number = gets.chomp
  puts 'Введите тип поезда (пассажирский или грузовой)'
  type = gets.chomp
  if number == 'выход' || type == 'выход'
    puts 'Завершение работы'
    break
  end
  begin
    train = Train.new(number, type)
    puts "Поезд под номером #{number} создан (тип: #{type})"
    puts 'Объект поезда:'
    p train
    trains[number] = train
  rescue Exception => e
    puts "Ошибка, повторите ввод. Причина: #{e.message}"
  end
end
