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
      @validations << [validation_type, attr_name, *args]
    end
  end

  module InstanceMethods
    def validate!
      # проверяем, если есть ли что-нибудь для проверки
      unless self.class.validations.nil?
        self.class.validations.each do |params|
          var = instance_variable_get("@#{params[1]}")
          case params.size
          when 2
            send params[0], var
          when 3
            send params[0], var, params[2]
          end
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

    def presence(attr)
      raise 'Ошибка: Параметр nil либо пуст' if attr.nil? || attr.empty?
    end

    def format(attr, regexp)
      raise "Ошибка: #{attr} не соответствует регулярному выражению #{regexp}" if (regexp =~ attr).nil?
    end

    # attrtype вместо type, чтобы не было конфликта с параметром type класса Train
    def attrtype(attr, type)
      raise "Ошибка: несоответствие типов, необходим #{type}, задан: #{attr.class}" if attr.class != type
    end
  end
end
