# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :validate

    def validate(name, type, *options)
      @validate ||= []
      @validate << {name: name, type: type, options: options}
    end
  end

  module InstanceMethods
    def validate!
      @error ||= []
      self.class.validate.each do |v|
        send(v[:type], instance_variable_get("@#{v:name]}".to_sym), v[:options])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def validate_presence(name)
      if instance_variable_get("@#{name}").nil? || instance_variable_get("@#{name}").empty?
        @error << "#{name} can't be nil or empty"
      end
    end

    def validate_type(name, class_name)
      unless instance_variable_get("@#{name}").is_a?(class_name)
        @error << "Error, #{name} dosn't match the class"
      end
    end

    def validate_format(name, format)
      if instance_variable_get("@#{name}") !~ format
        @error << "Error, #{name} dosn't match the format"
      end
    end
  end
end  
