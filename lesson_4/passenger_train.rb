class PassengerTrain < Train
  def initialize(number)
    super(number, "пассажирский")
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == "пассажирский"
  end
end
