class CargoWagon < Wagon
  attr_reader :wagon_type
    
  def initialize(wagon_type = 'cargo')
    super
  end
  
end


