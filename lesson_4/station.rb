# класс Станция
class Station
  # список всех поездов возвращается через переменную trains
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
    puts "Станция #{@name} - Поезд #{train.number} прибыл"
  end

  def show_trains_by_type(train_type)
    @trains.select { |train| train.type == train_type }
  end

  def send_train(train)
    @trains.delete(train)
    puts "Станция #{@name} - Поезд #{train.number} отправлен"
  end
end
