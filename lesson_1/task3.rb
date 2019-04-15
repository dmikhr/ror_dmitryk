# Прямоугольный треугольник

# метод для проверки, является ли треугольник равнобедренным
# input_data - входные данные
# delimiter - символ-разделитель входных данных, по умолчанию пробел
def ravnobedr(input_data, delimiter = " ")
  # разделяем строку на составляющие и переводим в float
  input_data = input_data.split(delimiter).map { |x| x.to_f }
  # погрешность при проверке на прямоугольность
  delta = 0.2
  # лямбда-функция проверки, что все числа больше 0
  positive_number = ->(x) { x > 0 ? true : false }
  # лямбда-функция проверки на прямоугольность по теореме Пифагора
  # вместо жесткой проверки a^2+b^2=c^2, проверяем, что разность квадрата гипотенузы и
  # суммы квадратов катетов меньше заданной погрешности a^2+b^2-c^2 < delta
  # с целью убрать возможные неточности при округлении
  pryamougolny = ->(hypotenuse, a, b) { hypotenuse**2 - (a**2 + b**2) < delta ? true : false }
  # лямбда-функция проверки на равнобедренность
  ravnobedrenny = ->(a, b) { a == b ? true : false }
  # лямбда-функция проверки, что треугольник равносторонний
  ravnostoronny = ->(hypotenuse, a, b) { hypotenuse == a && hypotenuse == b ? true : false }
  # проверка, все ли введенные параметры > 0
  if input_data.map { |x| positive_number.call(x) }.all?
    # находим гипотенузу, как самую длинную сторону треугольника
    hypotenuse = input_data.max
    # убираем значение гипотенузы из массива данных
    # в массиве останутся только значения длин катетов
    input_data.delete_at(input_data.find_index(hypotenuse))
    # переносим в переменные длины катетов
    a = input_data[0]
    b = input_data[1]
    # проверка на равносторонность
    is_ravnostoronny = ravnostoronny.call(hypotenuse, a, b)
    # проверка на прямоугольность
    is_pryamougolny = pryamougolny.call(hypotenuse, a, b)
    # проверка на равнобедренность
    is_ravnobedrenny = ravnobedrenny.call(a,b)
    # по полученным булевым значениям выводим соотвествующие сообщения
    if is_ravnostoronny
      puts "Треугольник не прямоугольный, но равнобедренный и равносторонний"
    elsif is_pryamougolny && is_ravnobedrenny
      puts "Треугольник прямоугольный и равнобедренный"
    elsif is_pryamougolny
        puts "Треугольник прямоугольный"
    else
      # если ни одно условие не выполнено
      puts "Обычный треугольник"
    end
  else
    puts "Все значения должны быть > 0"
  end
end

=begin
тестовые значения
2 3 3.6 - прямоугольный
3 4.24 3 - прямоугольный и равнобедренный
5 5 5 - равносторонний
=end

puts "Введите длины сторон треугольника (через пробел)"
# получаем данные
input_data = gets.chomp
# если введено меньше 3 параметров, то выводим сообщение об ошибке, иначе продолжаем
(input_data.split(" ").length < 3) ? (puts "Недостаточно параметров") : ravnobedr(input_data)
