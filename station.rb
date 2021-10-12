class Station
  attr_reader :name
  attr_accessor :trains
  
  include InstanceCounter

  @@stations = []
  
  def self.all
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    register_instance
  end
  
  def add_train(train)
    @trains << train
  end
  
  def train_type(type)
    @trains.select{ |train| train.train_type == type }
  end

  def go_train(train)
    @trains.delete(train) if @trains.include?(train)
    puts "clickety clack"
  end

end
