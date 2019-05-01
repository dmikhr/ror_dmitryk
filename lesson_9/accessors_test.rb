require_relative 'accessors'
require_relative 'production_company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'train'
require_relative 'station'

class AccessorsTest
  extend Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_acessor :qq, :xx

  def initialize(a = '')
    self.a = a
  end
end

a = AccessorsTest.new
p a.a
p a.b
# модифицируем переменные
a.b = 1
p a.b
a.b += 1
a.b += 2
a.b = 'some text'
a.b = true
p a.b
a.a = 'hello'
p a.a
a.a += ' world'
# p a.methods
# выводим историю значений
puts 'History'
p a.b_history
p a.a_history

puts 'Применение strong_attr_acessor'
# присваиваем строку в типом String
a.qq = 'qwe', String
p a.qq
# присваиваем число с типом Fixnum
a.xx = 12, Fixnum
p a.xx
# присваиваем массив с типом Array
a.xx = [1, 2, 3], Array
p a.xx

# присваиваем строку с типом Array - выводится исключение
# a.xx = 'hello', Array
# p a.xx

puts 'Демонстрация на классе Train работы attr_accessor_with_history'
train = Train.new('DD1-00', 'пассажирский')

train.number = 'ВВ100'
train.number = 'XX900'
# история изменений названия поезда
puts train.number_history

puts '======'
bb = AccessorsTest.new(10)

bb.a = 15
bb.a = 20
p bb

station1 = Station.new('Железнодорожная')
station1.name = 'Приозерная'
station1.name = 'Фрезер'
puts station1.name_history
station1.category = 'Пассажирская', String
# station1.category = 111, String
