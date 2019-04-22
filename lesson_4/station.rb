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
  end

  def show_trains_by_type(train_type)
    @trains.select { |train| train.type == train_type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
