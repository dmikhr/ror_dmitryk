require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'command'
require_relative 'commandprompt'

DEBUG = true
cmd = CommandPrompt.new

cmd.show_options
puts "\n"

# если DEBUG = true, то после каждого ввода в консоль будет печататься содержание переменных trains, stations, routes
def debug_data(cmd_obj)
  puts 'DEBUG: Trains'
  puts cmd_obj.trains.inspect
  puts 'DEBUG: Stations'
  puts cmd_obj.stations.inspect
  puts 'DEBUG: Routes'
  puts cmd_obj.routes.inspect
end

loop do
  puts 'Введите номер команды, которую необходимо выполнить (введите "выход" - для завершения)'
  input = gets.chomp
  if input == 'выход'
    puts 'Завершение работы'
    break
  end
  # элемент массива с методом на 1 меньше номера команды в списке
  if defined? cmd.commands[input.to_i - 1][1]
    cmd.commands[input.to_i - 1][1].call
    debug_data(cmd) if DEBUG
  else
    puts 'Неизвестная команда'
  end
end
