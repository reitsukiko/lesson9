class PassengerWagon < Wagon
  attr_reader :wagon_type
  
  def initialize(wagon_type = 'passenger')
    super
  end
  
end

