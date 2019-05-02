# класс пассажирского вагона
class PassengerCarriage < Carriage
  include Validation
  attr_reader :seats_num, :reserved_seats

  validate :id, :presence
  validate :id, :type, String
  validate :type, :presence
  validate :type, :type, String

  def initialize(id, seats_num)
    super(id, 'пассажирский')
    @seats_num = seats_num
    @reserved_seats = 0
  end

  def reserve_seat
    @reserved_seats += 1 if @reserved_seats + 1 <= @seats_num
  end

  def show_free_seats
    @seats_num - @reserved_seats
  end
end
