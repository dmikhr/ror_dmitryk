require_relative 'production_company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
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

# если DEBUG = true, то после каждого ввода в консоль
# будет печататься содержание переменных trains, stations, routes
# inspect на p
def debug_data(cmd_obj)
  puts 'DEBUG: Trains'
  p cmd_obj.trains
  puts 'DEBUG: Stations'
  p cmd_obj.stations
  puts 'DEBUG: Routes'
  p cmd_obj.routes
  puts 'DEBUG: Carriages'
  p cmd_obj.carriages
end

loop do
  puts 'Введите номер команды, которую необходимо выполнить'\
        ' (введите "999" - для завершения)'
  input = gets.chomp
  if input == '999'
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
