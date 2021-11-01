class Train
  attr_accessor :speed, :train_type, :manufacturer
  attr_reader :num_train, :current_station, :wagons
  
  include Company
  include InstanceCounter
  include Validation
  include ValidTrain
  
  @@trains = {}

  def initialize(num_train, train_type)
    @num_train = num_train
    @train_type = train_type
    @@trains[num_train] = train_type
    @wagons = []
    @speed = 0
    register_instance
    validate!
  end
  
  def self.find(num_train)
    return unless num_train == nil
    @@trains.find{ |train| train.num_train == num_train}
  end
  
  def Train.get_trains
    @@trains
    puts "Поезда: #{Train.get_trains}"
  end
  
  def stop
    self.speed = 0
  end

  def add_wagons(wagon)
    if @speed == 0
      @wagons << wagon if wagon.wagon_type == self.train_type
      wagon.wagon_to_train(self)
    else
      puts 'Необходимо остановить поезд, чтобы прицепить вагон'
    end
  end

  def delete_wagons(wagon)
    if @speed == 0
      @wagons.delete(wagon) if wagon.wagon_type == self.type
    else
      puts 'Необходимо остановить поезд, чтобы отцепить вагон'
    end
  end

  def take_route(route)
    @route << route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end
  
  def move_train
    return unless next_station
    @current_station.go_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def back_train
    return unless previous_station
    @current_station.go_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end
  
  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end
  
  def find_wagons
    wagons.each { |w| yield(w)}
  end
  
  def wagons_info
    find_wagons do |w|
      if w.wagon_type == 'cargo'
        puts "#{w.num_wagon}, #{w.wagon_type}, объём вагона #{w.cargo}, занято #{w.occupied_cargo}, осталось свободного места #{w.take_cargo}."
      else
        puts "#{w.num_wagon}, #{w.wagon_type}, в вагоне  мест #{w.place}, занято #{w.occupied_place}, свободных мест #{w.take_place}."
      end
  end
end
