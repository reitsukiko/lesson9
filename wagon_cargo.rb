# frozen_string_literal: true

class CargoWagon < Wagon
  include Validation
  include Accessors

  attr_reader :wagon_type
  attr_accessor :cargo
  validate :cargo, :format, CARGO 

  CARGO = /^\d{3}$/.freeze

  def initialize(num_wagon, wagon_type = 'cargo')
    super
    @cargo = 0
    validate!
  end

  def take_cargo(volume)
    @take_cargo = @cargo - volume
  end

  def free_cargo
    @take_cargo
  end

  def occupied_cargo
    @occupied_cargo = @cargo - @take_cargo
  end
end
