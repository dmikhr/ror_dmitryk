# класс Станция
class Station
  include InstanceCounter
  include Validation
  extend Accessors
  # список всех поездов возвращается через переменную trains
  attr_reader :trains
  # сохраняем историю переименований станции
  attr_accessor_with_history :name
  # введем новый параметр станции для демонстрации работы strong_attr_acessor
  strong_attr_acessor :category

  validate :name, :presence
  validate :name, :attrtype, String

  # переменная класса - массив, который будет содержать все экземпляры класса
  @@stations = []

  # метод класса - вывод всех станций
  def self.all
    @@stations
  end

  def initialize(name)
    # изменено с @name на self.name чтобы при создании объекта
    # был вызван setter и 1-ое значение тоже сохранилось в истории значений
    self.name = name
    @trains = []
    @category = 'Товарная', String
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
end
