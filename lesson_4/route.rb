# класс Маршрут
class Route

  attr_reader :stations

  def initialize(first_station, end_station)
    @stations = [first_station, end_station]
  end

  def add_station(station, position)
    # станция должна находиться между начальной и конечной
    if position > 0 && position < @stations.size
      @stations.insert(position, station)
    else
      puts 'Можно добавить только промежуточную станцию'
    end
  end

  def delete_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    else
      puts 'Можно удалить только промежуточную станцию'
    end
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end
