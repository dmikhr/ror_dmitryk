class CargoTrain < Train
  def initialize(number)
    super(number, "грузовой")
  end

  def add_carriage(carriage)
    if carriage.type == "грузовой"
      super(carriage)
    else
      puts 'Можно прицепить только грузовой вагон'
      return false
    end
  end
end
