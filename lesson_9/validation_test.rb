require_relative 'validation'

class TestVal
  include Validation

  attr_accessor :a, :b

  validate :a, :presence
  validate :a, :format, /^[A-Z]{0,3}$/
  validate :a, :attrtype, String
  validate :b, :presence
  validate :b, :format, /^[A-Z]{0,3}$/
  validate :b, :attrtype, String

  def initialize
    @a = 'AZZ'
    @b = 'Z'
    validate!
  end
end

cl = TestVal.new

# valid? - true
puts cl.valid?
# делаем параметр a пустой строкой - теперь valid? выдаст false
cl.a = ''
puts cl.valid?
