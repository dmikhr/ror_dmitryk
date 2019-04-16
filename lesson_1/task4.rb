# Квадратное уравнение

# метод для проверки, является ли треугольник равнобедренным
# input_data - входные данные
# delimiter - символ-разделитель входных данных, по умолчанию пробел
def solve_square_eq(input_data, delimiter = " ")
  # разделяем строку на составляющие и переводим в float
  input_data = input_data.split(delimiter).map { |x| x.to_f }
  # переносим данные в переменные
  a, b, c = input_data
  # вычисляем дискриминант
  d = b**2 - 4 * a * c
  # если дискриминант положительный
  # находим 2 корня уравнения
  if d > 0
    sqrt_d = Math.sqrt(d)
    x1 = -b + sqrt_d / (2 * a)
    x2 = -b - sqrt_d / (2 * a)
    # выводим корни, ограничиваем float до 2 знаков после запятой
    puts "Корни уравнения: x1=%.2f x2=%.2f" % [x1, x2]
  # если дискриминант равен 0
  # уравнение имеет 1 корень
  elsif d == 0
    x = -b / (2 * a)
    # выводим корень, ограничиваем float до 2 знаков после запятой
    puts "Корень уравнения: x=%.2f" % x
  # оставшийся случай - дискриминант меньше 0
  # в таком случае корней нет
  else
    puts "Корней нет"
  end
end

=begin
тестовые значения a,b,c
2 15 1 - 2 корня
1 6 9 - 1 корень
2 3 4 - нет корней
=end

puts "Введите 3 коэффициента квадратного уравнения: a, b и с (через пробел)"
# получаем данные
input_data = gets.chomp
# если введено меньше 3 параметров, то выводим сообщение об ошибке, иначе продолжаем
(input_data.split(" ").length < 3) ? (puts "Недостаточно параметров") : solve_square_eq(input_data)
