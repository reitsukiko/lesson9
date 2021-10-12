class RailRoad
  attr_reader :stations, :trains, :routes, :wagons, :rr_menu, :rr_menu2, :input, :rr_menu2_input

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end
  
  def menu
    loop do
      self.rr_menu
      
      if @input == 0
        break
      else
        self.rr_menu2
        point = self.rr_menu2_input
      end
      
      case point
      when 1
        self.new_train
      when 2
        self.new_wagon
      when 3
        self.new_station
      when 4
        self.new_route
      when 5
        self.add_wagon
      when 6
        self.delete_wagon
      when 7
        self.add_station
      when 8
        self.delete_station
      when 9
        self.take_route
      when 10
        self.move_train
      when 11
        self.back_train
      when 12
        self.trains_list
      when 13
        self.station_list
      else
        puts 'Команды нет в списке'
      end
    end
  end
  
  private
  attr_writer :stations, :trains, :routes, :wagons
  
  def rr_menu
    puts "1. Создать: поезда, вагоны, станции, маршрут"
    puts "2. Управлять созданными объектами"
    puts "3. Данные о созданных объектах"
    puts "0. Выйти"
    puts "Выберите вариант: "
    @input = gets.chomp.to_i
  end
      
  def rr_menu2
    if @input == 1
      puts "Для создания поезда нажмите 1"
      puts "Для создания вагона нажмите 2"
      puts "Для создания станции нажмите 3"
      puts "Для создания маршрута нажмите 4"
    elsif @input == 2
      puts "Для добавления вагона нажмите 5, для удаления вагона 6"
      puts "Чтобы добавить станцию в маршрут нажмите 7, удалить станцию 8"
      puts "Назначить маршрут поезду 9"
      puts "Для перемещения поезда вперёд 10, для перемещения поезда назад 11"
    elsif @input == 3
      puts "Для просмотра созданных поездов нажмите 12, станций 13"
    end
  end
  
  def rr_menu2_input
    @rr_menu2_input = gets.chomp.to_i
  end
  
  def new_train
    print "Назовите поезд: "
    train = gets.chomp.downcase
    
    print "Номер поезда: "
    num_train = gets.chomp.to_i

    print "Укажите тип поезда(cargo, passenger): "
    train_type = gets.chomp.downcase

    if train_type == "cargo"
      train = TrainCargo.new(num_train, train_type)
      @trains.push(TrainCargo.new(num_train, train_type))
    elsif train_type == "passenger"
      train = TrainPassenger.new(num_train, train_type)
      @trains.push(TrainPassenger.new(num_train, train_type))
    end
    puts "Вы создали поезд #{trains.last.train}."
  end
  
  def new_wagon
    print "Назовите вагон"
    wagon = gets.chomp.downcase
    
    print "Номер вагона: "
    num_wagon = gets.chomp.to_i
  
    print "Укажите тип вагона(passenger, cargo): "
    wagon_type = gets.chomp.downcase
  
    if wagon_type == 'cargo'
      wagon = WagonCargo.new(num_wagon, wagon_type)
      @wagons.push(WagonCargo.new(num_wagon, wagon_type))
    elsif
      wagon_type == 'passenger'
      wagon = WagonPassenger.new(num_wagon, wagon_type)
      @wagons.push(WagonPassenger.new(num_wagon, wagon_type))
    end
    puts "Вы создали вагон #{wagons.last.wagon}."
  end
  
  def new_station
    print "Название станции: "
    station_name = gets.chomp.downcase
    
    station = Station.new(station_name)
    @stations.push(Station.new(station_name))
    puts "Вы создали станцию #{stations.last.station}."
  end
  
  def new_route
    print "Название маршрута: "
    name_route = gets.chomp.downcase
    
    print "Первая станция маршрута: "
    first_station = gets.chomp.downcase
    
    print "Последняя станция маршрута: "
    last_stations = gets.chomp.downcase
    
    name_route = Route.new(first_station, last_stations)
    @routes.push(Route.new(first_station, last_stations))
    puts "Вы создали маршрут #{routes.last(2)}."
  end
  
  def add_wagon
    print "Номер поезда, к которому необходимо добавить вагон: "
    num_train = gets.chomp.to_i
    
    print "Номер вагона: "
    num_wagon = gets.chomp.to_i
    
    train = search_train(num_train)
    wagon = search_wagon(num_wagon)
    if wagon.type == train.type
      num_train = get_train(num_train)
      trains.fetch(num_train).add_wagon(num_wagon)
      puts "Вагон успешно добавлен"
    else
      puts "Указанных поезда/вагона не существует, добавление невозможно"
    end
  end

  def delete_wagon
    print "Номер поезда, к которому необходимо добавить вагон: "
    num_train = gets.chomp.to_i
  
    print "Номер вагона: "
    num_wagon = gets.chomp.to_i
  
    train = search_train(num_train)
    wagon = search_wagon(num_wagon)
    if wagon.wagon_type == train.train_type
      @trains.delete(num_wagon)
      puts "Вагон удалён"
    else
      puts "Указанных поезда/вагона не существует, добавление невозможно"
    end
  end
  
  def add_station
    print "Укажите маршрут, к которому необходимо добавить станцию: "
    route_name = gets.chomp.downcase
    
    print "Название станции: "
    station_name = gets.chomp.downcase
    
    route_name = get_route(route_name)
    station_name = get_station(station_name)
    
    if routes.fetch(route_name).add_station(stations.fetch(station_name))
      puts "В маршрут добавлена станция"
    else
      puts "Указанных маршрута/станции не существует"
    end
  end

  def delete_station
    print "Укажите маршрут, в котором необходимо удалить станцию: "
    route_name = gets.chomp.downcase
    
    print "Название станции: "
    station_name = gets.chomp.downcase
    
    route_name = get_route(route_name)
    station_name = get_station(station_name)
    
    if routes.fetch(route_name).delete_station(stations.fetch(station_name))
      puts "Станция была удалена из маршрута"
    else
      puts "Указанных маршрута/станции не существует"
    end
  end
  
  def take_route
    print "Номер поезда, которому будет назначен маршрут: "
    num_train = gets.chomp.to_i
    
    print "Название маршрута, который будет назначен поезду: "
    route_name = gets.chomp.downcase
      
    number = get_train(number)
    route_name = get_route(route_name)
      
    if trains.fetch(number).take_route(routes.fetch(route_name))
      puts "Поезду назначен маршрут"
    else
      puts "Указанных поезда/маршрута не существует"
    end
  end

  def move_train
    print "Номер поезда: "
    num_train = gets.chomp.to_i
      
    num_train = get_train(num_train)
    if trains.fetch(num_train).move_train(self)
      puts "Поехали!"
    else
      puts "Отправление не удалось, поезда не существует"
    end
  end

  def back_train
    print "Номер поезда: "
    num_train = gets.chomp.to_i
      
    num_train = get_train(num_train)
    if trains.fetch(num_train).back_train(self)
      puts "Возвращаемся!"
    else
      puts "Мы не можем вернуться, поезда не существует"
    end
  end

  def list_stations
    puts "#{@stations}"
  end

  def list_trains
    puts "#{@trains}"
  end
  
  def get_train(num_train)
    @trains.index(num_train)
  end
  
  def get_wagon(wagon_type)
    @wagons.index(wagon_type)
  end
  
  def get_route(route_name)
    @route.index(route_name)
  end
  
  def get_station(station_name)
    @station.index(station_name)
  end

  def search_train(num_train)
    @trains.find { |train| train.type == train_type}
  end

  def search_wagon(num_wagon)
    @wagons.find { |wagon| wagon.type == wagon_type}
  end
end



