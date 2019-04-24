# класс Маршрут
class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(first_station, end_station)
    @stations = [first_station, end_station]
    validate!
    register_instance
  end

  def add_station(station, position)
    @stations.insert(position, station) if middle_statinon?(position)
  end

  def delete_station(station)
    @stations.delete(station) unless border_station(station)
  end

  private
  # методы для использования внутри класса
  def middle_statinon?(position)
    position > 0 && position < @stations.size
  end

  # ture - если станция крайняя в маршруте (начальная или конечная)
  def border_station(station)
    station == @stations.first || station == @stations.last
  end

  def validate!
    raise 'Для создания маршрута необходимы объекты класса Station' unless @stations.first.class == Station && @stations.last.class == Station
    raise 'Для создания маршрута необходимы 2 разные станции' if @stations.first == @stations.last
  end
end
