# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

$months = {"Январь" => 31, "Февраль" => 28, "Март" => 31, "Апрель" => 30,
   "Май" => 31, "Июнь" => 30, "Июль" => 31, "Август" => 31, "Сентябрь" => 30,
   "Октябрь" => 31, "Ноябрь" => 30, "Декабрь" => 31}

# определение високосного года
def leap_year(year)
  if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
    return true
  else
    return false
  end
end

def days_from_year_beginning(input_data)
  day, month, year = input_data.split(" ").map{ |x| x.to_f }
  # если год високосный - изменяем количество дней для Февраля в хеше на 29 вместо 28
  if leap_year(year)
    puts "Високосный год"
    $months["Февраль"] = 29
  end
  # счетчик дней с начала года
  days_from_start = 0
  # суммируем дни в уже прошедших месяцах
  for i in 0..month-2
    days_from_start += $months[$months.keys[i]]
  end
  # добавляем кол-во дней в месяце, введенном пользователем
  puts "Дней с начала года: #{days_from_start + day}"
end

puts "Введите число, месяц, год"
input_data = gets.chomp
(input_data.split(" ").length < 3) ? (puts "Недостаточно параметров") : days_from_year_beginning(input_data)
