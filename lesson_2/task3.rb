# Заполнить массив числами фибоначчи до 100

# метод вычисления числа Фибоначчи
# f - массив уже имеющихся чисел
def fibonacci(f)
  i = f.size
  f[i-2] + f[i-1]
end
# начальные данные f1=0, f2=1
fib_numbers = [0]
fib_number = 1

# генерируем числа Фибоначчи до 100
while fib_number < 100 do
  fib_numbers.push(fib_number)
  fib_number = fibonacci(fib_numbers)
end

puts "Числа Фибоначчи"
puts fib_numbers
