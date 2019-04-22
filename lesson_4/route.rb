# класс Маршрут
class Route

  attr_reader :stations

  def initialize(first_station, end_station)
    @stations = [first_station, end_station]
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
end
