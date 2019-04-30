# класс Вагон
class Carriage
  include ProductionCompany
  include InstanceCounter
  include Validation

  attr_reader :id, :type

  def initialize(id, type)
    # каждый вагон будет иметь id по которому
    # им можно будет управлять (прицеплять, отцеплять)
    @id = id
    @type = type
    validate!
    register_instance
  end

  protected

  def validate!
    raise 'id вагона должен быть текстовым' unless @id.class == String
    raise 'id вагона не задан' if @id == ''

    unless %w[пассажирский грузовой].include?(@type)
      raise 'Недопустимый тип вагона "\
      "(должен быть "пассажирский" или "грузовой")'
    end
  end
end
