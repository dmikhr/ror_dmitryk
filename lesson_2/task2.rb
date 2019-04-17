# Заполнить массив числами от 10 до 100 с шагом 5
array_numbers = []
10.step(100, 5) { |x| array_numbers.push(x) }
puts array_numbers
