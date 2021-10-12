module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end
  
  module ClassMethods
    attr_writer :instances
  
    def counter
      @instances ||= 0
    end
    
    protected
    def add_instance
      @instances += 1
    end
  end
  
  module InstanceMethods
    def register_instance
      self.class.add_instance
    end
  end
end
