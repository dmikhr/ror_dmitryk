# т.к. метод valid? для всех классов реализуется одинаково,
# вынесем его в отдельный модуль
module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
