# Площадь треугольника

# метод для вычисления площади треугольника
# input_data - входные данные
# delimiter - символ-разделитель входных данных, по умолчанию пробел
def calculate_triangle_area(input_data, delimiter=" ")
  # лямбда-функция проверки, что все числа больше 0
  positive_number = ->(x) { x > 0 ? true : false }
  # разделяем строку на составляющие и переводим в float
  a, h = input_data.split(delimiter).map { |x| x.to_f }
  # проверяем все ли числа > 0
  # через map применяем лямбда-функцию positive_number к каждому числу
  # map вернет набор булевых значений, через .all? проверяем, все ли они true
  if [a,h].map { |x| positive_number.call(x) }.all?
    # вычисляем площадь треугольника
     triangle_area = 0.5 * a.to_f * h.to_f
     # выводим площадь треугольника
     puts "Площадь треугольника: #{triangle_area}"
   else
     # иначе сообщение об ошибке
     puts "Все параметры должны быть > 0"
   end
end

puts "Введите основание и высоту треугольника"
# получаем данные
input_data = gets.chomp
# если введено меньше 2 параметров, то выводим сообщение об ошибке, иначе продолжаем
(input_data.split(" ").length < 2) ? (puts "Недостаточно параметров") : calculate_triangle_area(input_data)
