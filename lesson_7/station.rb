# класс Станция
class Station
  include InstanceCounter
  include Validation
  # список всех поездов возвращается через переменную trains
  attr_reader :name, :trains

  # переменная класса - массив, который будет содержать все экземпляры класса
  @@stations = []

  # метод класса - вывод всех станций
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    # заносим сам объект в массив
    @@stations << self
    validate!
    register_instance
  end

  # метод для блока
  def each_train
    # пройти по всем поездам, передавая каждый объект в блок
    @trains.each { |train| yield(train) } if block_given?
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

  private
  def validate!
    raise 'Названые станции должно быть текстовым' unless @name.class == String
    raise 'Названые станции не задано' if @name == ''
  end
end
