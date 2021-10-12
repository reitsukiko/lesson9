class Route
  attr_accessor :stations
  
  include InstanceCounter
  
  def initialize(first_station, last_station)
    @stations = []
    @stations.push(first_station, last_station)
    register_instance
  end

  def add_station(stations)
    @stations.insert(-2, stations)
  end

  def delete_station(stations)
    @stations.delete(stations)
  end
end
