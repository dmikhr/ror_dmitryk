# Сумма покупок

goods = {}

loop do
  puts "Введите наименование товара, стоимость и количество (через пробел)"
  input_data = gets.chomp
  if input_data == "стоп"
    break
  elsif input_data.split(" ").length < 3
    puts "Недостаточно данных"
  else
    item_name, price, amount = input_data.split(" ")
    price = price.to_f
    amount = amount.to_f
    goods[item_name] = {price => amount}
  end
end

total_price = 0

goods.each do |item_name, price_amount|
  # итоговая сумма за товар
  price_all = price_amount.keys[0] * price_amount.values[0]
  # цена всех покупок
  total_price += price_all
  puts "Товар: #{item_name}, Цена:#{price_amount.keys[0]}, Количество: #{price_amount.values[0]}, Итого: #{price_all}"
end

puts "Общая сумма покупок #{total_price}"
