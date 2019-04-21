class Carriage
  attr_reader :id, :type
  def initialize(id, type)
    # каждый вагон будет иметь id по которому им можно будет управлять (прицеплять, отцеплять)
    @id = id
    @type = type
  end
end
