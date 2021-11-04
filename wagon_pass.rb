# frozen_string_literal: true

class PassengerWagon < Wagon
  include Validation
  include ValidPlace

  attr_reader :wagon_type
  attr_accessor :place

  def initialize(num_wagon, wagon_type = 'passenger')
    super
    @place = 0
    validate!
  end

  def take_place
    @take_place = @place - 1
  end

  def free_place
    @take_place
  end

  def occupied_place
    @occupied_place = @place - @take_place
  end
end
