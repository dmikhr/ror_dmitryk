module InstanceCounter
  # обработка hook при подключении модуля
  def self.included(base)
    # подключение методов класса
    base.extend ClassMethods
    # подключение инстанс-методов: т.к. include - private метод, вызываем его через send
    base.send :include, InstanceMethods
  end

  module ClassMethods
    # переменная класса - счетчик, в котором будут
    # считаться созданные инстансы
    # вывод количества классов реализуется через геттер
    # увеличение счетчика через сеттер в методе register_instance
    attr_accessor :instances
  end

  module InstanceMethods
    # делаем метод protected, т.к. у классов, к которому модуль подключается
    # могут быть подклассы
    protected
    def register_instance
      # если значение instances еще не задано, то  присваиваем 1
      # иначе прибавляем 1
      self.class.instances.nil? ? self.class.instances = 1 : self.class.instances += 1
    end

  end
end
