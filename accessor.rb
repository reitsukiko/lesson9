module Acсessors
  def self.included(base)
    base.extend(MyAttrAccessor)
  end

  module MyAttrAccessor
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_name = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(history_name, [])
          instance_variable_get(history_name).push(value)
        end

        define_method("@#{name}_history".to_sym) { instance_variable_get(history_name) }
      end
    end

    def strong_attr_accessor (name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise 'Incorrect class' unless value.is_a?(class_name)
        instance_variable_set(var_name, value)
      end
   end
end
