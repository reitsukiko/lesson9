module Validation
  def valid?
    validate!
  rescue
    false
  end
end

module ValidTrain
  NUM_TRAIN = /^\d{3}[а-я]{2}$/i
  def validate!
    raise "Номер не может быть пустым" if num_train.nil?
    raise "Неверный формат номера" if num_train !~ NUM_TRAIN
  end
end

module ValidWagon
  NUM_WAGON = /^\d{3}$/i
  def validate!
    raise "Номер не может быть пустым" if num_wagon.nil?
    raise "Неверный формат номера" if num_wagon !~ NUM_WAGON
  end
end

module ValidStation
  NAME = /^\w$/
  def validate!
    raise "Неверный формат" if station_name !~ NAME
  end
end

