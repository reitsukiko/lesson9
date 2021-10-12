class TrainCargo < Train
  
  def initialize(num_train, train_type)
    super
    @train_type = 'cargo'
  end

end
