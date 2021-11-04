# frozen_string_literal: true

class RailRoad
  include Validation
  include ValidTrain
  include ValidWagon
  include ValidStation
  include ValidPlace
  include ValidCargo

  attr_reader :stations, :trains, :routes, :wagons, :rr_menu, :rr_menu2, :input, :rr_menu2_input

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    validate!
  end

  def menu
    loop do
      rr_menu

      if @input.zero?
        break
      else
        rr_menu2
        point = rr_menu2_input
      end

      case point
      when 1 then new_train
      when 2 then new_wagon
      when 3 then new_station
      when 4 then new_route
      when 5 then add_wagon
      when 6 then delete_wagon
      when 7 then cargo_place
      when 8 then add_station
      when 9 then delete_station
      when 10 then take_route
      when 11 then move_train
      when 12 then back_train
      when 13 then trains_list
      when 14 then station_list
      when 15 then wagon_list
      when 16 then wagon_train
      when 17 then wagon_station
      else
        puts 'Команды нет в списке'
      end
    end
  end

  private

  attr_writer :stations, :trains, :routes, :wagons

  def rr_menu
    puts '1. Создать: поезда, вагоны, станции, маршрут'
    puts '2. Управлять созданными объектами'
    puts '3. Данные о созданных объектах'
    puts '0. Выйти'
    puts 'Выберите вариант: '
    @input = gets.chomp.to_i
  end

  def rr_menu2
    case @input
    when 1
      puts 'Для создания поезда нажмите 1'
      puts 'Для создания вагона нажмите 2'
      puts 'Для создания станции нажмите 3'
      puts 'Для создания маршрута нажмите 4'
    when 2
      puts 'Для добавления вагона нажмите 5, для удаления вагона 6. Занять в вагоне место/объём - 7'
      puts 'Чтобы добавить станцию в маршрут нажмите 8, удалить станцию 9'
      puts 'Назначить маршрут поезду 10'
      puts 'Для перемещения поезда вперёд 11, для перемещения поезда назад 12'
    when 3
      puts 'Для просмотра созданных поездов нажмите 13, станций 14, вагонов 15'
      puts 'Для просмотра вагонов определённого поезда нажмите 16, поездов на конкретной станции нажмите 17'
    end
  end

  def rr_menu2_input
    @rr_menu2_input = gets.chomp.to_i
  end

  def new_train
    print 'Назовите поезд: '
    train = gets.chomp.downcase

    print 'Номер поезда: '
    num_train = gets.chomp.to_i

    print 'Укажите тип поезда(cargo, passenger): '
    train_type = gets.chomp.downcase

    case train_type
    when 'cargo'
      train = TrainCargo.new(num_train, train_type)
      @trains.push(TrainCargo.new(num_train, train_type))
    when 'passenger'
      train = TrainPassenger.new(num_train, train_type)
      @trains.push(TrainPassenger.new(num_train, train_type))
    end
    puts "Вы создали поезд #{trains.last.train}."
  end

  def new_wagon
    print 'Номер вагона: '
    num_wagon = gets.chomp.to_i

    print 'Укажите тип вагона(passenger, cargo): '
    wagon_type = gets.chomp.downcase

    if wagon_type == 'cargo'
      puts 'Укажите объём вагона'
      cargo = gets.chomp.to_i

      wagon = WagonCargo.new(num_wagon, wagon_type, cargo)
      @wagons.push(WagonCargo.new(num_wagon, wagon_type, cargo))
    else
      puts 'Укажите количество мест в вагоне'
      place = gets.chomp.to_i

      wagon = WagonPassenger.new(num_wagon, wagon_type, place)
      @wagons.push(WagonPassenger.new(num_wagon, wagon_type, place))
    end
    puts "Вы создали вагон #{wagons.last.wagon}."
  end

  def new_station
    print 'Название станции: '
    station_name = gets.chomp.downcase

    station = Station.new(station_name)
    @stations.push(Station.new(station_name))
    puts "Вы создали станцию #{stations.last.station}."
  end

  def new_route
    print 'Название маршрута: '
    name_route = gets.chomp.downcase

    print 'Первая станция маршрута: '
    first_station = gets.chomp.downcase

    print 'Последняя станция маршрута: '
    last_stations = gets.chomp.downcase

    name_route = Route.new(first_station, last_stations)
    @routes.push(Route.new(first_station, last_stations))
    puts "Вы создали маршрут #{routes.last(2)}."
  end

  def add_wagon
    print 'Номер поезда, к которому необходимо прицепить вагон: '
    num_train = gets.chomp.to_i

    print 'Номер вагона: '
    num_wagon = gets.chomp.to_i

    train = search_train(num_train)
    num_wagon = search_wagon(num_wagon)
    if wagon.type == train.type
      num_train = get_train(num_train)
      trains.fetch(num_train).add_wagon(num_wagon)
      puts 'Вагон успешно добавлен'
    else
      puts 'Указанных поезда/вагона не существует, добавление невозможно'
    end
  end

  def delete_wagon
    print 'Номер поезда, у которого необходимо отцепить вагон: '
    num_train = gets.chomp.to_i

    print 'Номер вагона: '
    num_wagon = gets.chomp.to_i

    train = search_train(num_train)
    num_wagon = search_wagon(num_wagon)
    if wagon.wagon_type == train.train_type
      @trains.delete(num_wagon)
      puts 'Вагон удалён'
    else
      puts 'Указанных поезда/вагона не существует, добавление невозможно'
    end
  end

  def add_station
    print 'Укажите маршрут, к которому необходимо добавить станцию: '
    route_name = gets.chomp.downcase

    print 'Название станции: '
    station_name = gets.chomp.downcase

    route_name = get_route(route_name)
    station_name = get_station(station_name)

    if routes.fetch(route_name).add_station(stations.fetch(station_name))
      puts 'В маршрут добавлена станция'
    else
      puts 'Указанных маршрута/станции не существует'
    end
  end

  def delete_station
    print 'Укажите маршрут, в котором необходимо удалить станцию: '
    route_name = gets.chomp.downcase

    print 'Название станции: '
    station_name = gets.chomp.downcase

    route_name = get_route(route_name)
    station_name = get_station(station_name)

    if routes.fetch(route_name).delete_station(stations.fetch(station_name))
      puts 'Станция была удалена из маршрута'
    else
      puts 'Указанных маршрута/станции не существует'
    end
  end

  def take_route
    print 'Номер поезда, которому будет назначен маршрут: '
    num_train = gets.chomp.to_i

    print 'Название маршрута, который будет назначен поезду: '
    route_name = gets.chomp.downcase

    num_train = get_train(num_train)
    route_name = get_route(route_name)

    if trains.fetch(num_train).take_route(routes.fetch(route_name))
      puts 'Поезду назначен маршрут'
    else
      puts 'Указанных поезда/маршрута не существует'
    end
  end

  def move_train
    print 'Номер поезда: '
    num_train = gets.chomp.to_i

    num_train = get_train(num_train)
    if trains.fetch(num_train).move_train(self)
      puts 'Поехали!'
    else
      puts 'Отправление не удалось, поезда не существует'
    end
  end

  def back_train
    print 'Номер поезда: '
    num_train = gets.chomp.to_i

    num_train = get_train(num_train)
    if trains.fetch(num_train).back_train(self)
      puts 'Возвращаемся!'
    else
      puts 'Мы не можем вернуться, поезда не существует'
    end
  end

  def cargo_place
    print 'Номер вагона: '
    num_wagon = gets.chomp.to_i

    num_wagon = search_wagon(num_wagon)
    if wagon.wagon_type == 'cargo'
      puts 'Укажите объём, который нужно занять'
      volume = gets.chomp.to_i

      num_wagon = get_wagon(num_wagon)
      @wagons.fetch(num_wagon).take_cargo(volume)
    else
      num_wagon = get_wagon(num_wagon)
      @wagons.fetch(num_wagon).take_place(self)
    end
  end

  def wagon_train
    print 'Введите номер поезда'
    num_train = gets.chomp.to_i

    num_train = get_train(num_train)
    @trains.fetch(num_train).wagons_info(self)
  end

  def train_station
    print 'Введите название станции'
    station_name = gets.chomp.downcase

    station_name = get_station(station_name)
    @stations.fetch(station_name).trains_info(self)
  end

  def list_stations
    puts @stations.to_s
  end

  def list_trains
    puts @trains.to_s
  end

  def wagons_list
    puts @wagons.to_s
  end

  def get_train(num_train)
    @trains.index(num_train)
  end

  def get_wagon(num_wagon)
    @wagons.index(num_wagon)
  end

  def get_route(route_name)
    @route.index(route_name)
  end

  def get_station(station_name)
    @station.index(station_name)
  end

  def search_train(_num_train)
    @trains.find { |train| train.num_train == train_type }
  end

  def search_wagon(_num_wagon)
    @wagons.find { |wagon| wagon.num_wagon == wagon_type }
  end
end
