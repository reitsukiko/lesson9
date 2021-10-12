class TrainPassenger < Train
  
  def initialize(num_train, train_type)
    super
    @train_type = 'passenger'
  end

end
