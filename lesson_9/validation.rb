module Validation
  # обработка hook при подключении модуля
  def self.included(base)
    # подключение методов класса
    base.extend ClassMethods
    # подключение инстанс-методов: т.к. include - private метод,
    # вызываем его через send
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(attr_name, validation_type, *args)
      @validations ||= []
      @validations << { type: validation_type, var: attr_name, args: args }
    end
  end

  module InstanceMethods
    def validate!
      # проверяем, если есть ли что-нибудь для проверки
      unless self.class.validations.nil?
        self.class.validations.each do |params|
          var = instance_variable_get("@#{params[:var]}")
          send "validate_#{params[:type]}", var, *params[:args]
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(attr)
      raise 'Ошибка: Параметр nil либо пуст' if attr.nil? || attr.empty?
    end

    def validate_format(attr, regexp)
      raise "Ошибка: #{attr} не соответствует регулярному выражению #{regexp}" if (regexp =~ attr).nil?
    end

    def validate_type(attr, type)
      raise "Ошибка: несоответствие типов, необходим #{type}, задан: #{attr.class}" if attr.class != type
    end
  end
end
