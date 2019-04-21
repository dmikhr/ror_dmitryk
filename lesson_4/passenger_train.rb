class PassengerTrain < Train
  def initialize(number)
    super(number, "пассажирский")
  end

  def add_carriage(carriage)
    if carriage.type == "пассажирский"
      super(carriage)
    else
      puts 'Можно прицепить только пассажирский вагон'
      return false
    end
  end
end
