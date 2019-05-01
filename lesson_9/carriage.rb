# класс Вагон
class Carriage
  include ProductionCompany
  include InstanceCounter
  include Validation

  attr_reader :id, :type

  validate :id, :presence
  validate :id, :attrtype, String
  validate :type, :presence
  validate :type, :attrtype, String

  def initialize(id, type)
    # каждый вагон будет иметь id по которому
    # им можно будет управлять (прицеплять, отцеплять)
    @id = id
    @type = type
    validate!
    register_instance
  end
end
