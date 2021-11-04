# frozen_string_literal: true

module Validation
  def valid?
    validate!
  rescue StandardError
    false
  end
end

module ValidTrain
  NUM_TRAIN = /^\d{3}[а-я]{2}$/i.freeze
  def validate!
    raise 'Номер не может быть пустым' if num_train.nil?
    raise 'Неверный формат номера' if num_train !~ NUM_TRAIN
  end
end

module ValidWagon
  NUM_WAGON = /^\d{3}$/.freeze
  def validate!
    raise 'Номер не может быть пустым' if num_wagon.nil?
    raise 'Неверный формат номера' if num_wagon !~ NUM_WAGON
  end
end

module ValidStation
  NAME = /^\w$/.freeze
  def validate!
    raise 'Неверный формат' if station_name !~ NAME
  end
end

module ValidPlace
  PLACE = /^\d{2}$/.freeze
  def validate!
    raise 'Количество мест должно быть в диапазоне 10-60' if place !~ PLACE
  end
end

module ValidCargo
  CARGO = /^\d{3}$/.freeze
  def validate!
    raise 'Объём вагона должен быть в диапазоне 100-300' if cargo !~ CARGO
  end
end
