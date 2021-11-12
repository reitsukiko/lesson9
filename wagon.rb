# frozen_string_literal: true

class Wagon
  include Company
  include Validation
  include Accessors

  attr_reader :num_wagon, wagon_type, trains
  attr_accessor :manufacturer
  validate :num_wagon, :format, NUM_WAGON

  NUM_WAGON = /^\d{3}$/.freeze

  @@wagons = {}

  def initialize(num_wagon, wagon_type)
    @num_wagon = num_wagon
    @wagon_type = wagon_type
    @@wagons[num_wagon] = wagon_type
    @trains = []
    validate!
  end

  def self.get_wagons
    @@wagons
    puts "Вагоны: #{self.get_wagons}"
  end

  def wagon_to_train(train)
    @trains << train if train.wagons.include?(self)
  end
end
