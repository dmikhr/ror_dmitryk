class CargoTrain < Train
  def initialize(number)
    super(number, "грузовой")
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == "грузовой"      
  end
end
