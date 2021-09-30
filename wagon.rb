class Wagon
  attr_reader :num_wagon, wagon_type
  
  @@wagons = {}
  
  def initialize(num_wagon, wagon_type)
    @num_wagon = num_wagon
    @wagon_type = wagon_type
    @@wagons[num_wagon] = wagon_type
    @trains = []
  end
  
  def Wagon.get_wagons
    @@wagons
    puts "Вагоны: #{Wagon.get_wagons}"
  end
  
  def wagon_to_train(train)
    @wagon = train.add_wagon if train.wagons.include?(self)
  end
end 


