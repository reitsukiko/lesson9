class Train
  attr_accessor :speed
  attr_reader :number, :type, :wagons, :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end
  
  def stop
    self.speed = 0
  end

  def add_wagons
    self.wagons += 1 if @speed == 0
  end

  def remove_wagons
    self.wagons -= 1 if @speed == 0
  end

  def take_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_train
    @current_station.go_train(self)
    @current_station = next_station
    @current_station.add_train(self)
    @current_station
  end

  def back_train
    @current_station.go_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
    @current_station
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end

end
