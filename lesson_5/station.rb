# класс Станция
class Station
  include InstanceCounter
  # список всех поездов возвращается через переменную trains
  attr_reader :name, :trains

  # переменная класса - массив, который будет содержать все экземпляры класса
  @@stations = []

  # метод класса - вывод всех станций
  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    # заносим сам объект в массив
    @@stations << self
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
