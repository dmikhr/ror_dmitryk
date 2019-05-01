module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      # getter
      define_method(arg) { instance_variable_get("@#{arg}") }
      # setter
      define_method("#{arg}=") do |var|
        # если массив историй значений переменной не существовал - создаем его
        instance_variable_set("@#{arg}_history", []) if instance_variable_get("@#{arg}_history").nil?
        # добавляем предыдущее значение в массив
        # https://stackoverflow.com/questions/46896904/push-element-to-dynamic-array-created-with-instance-variable-set-in-rails
        old_var = instance_variable_get("@#{arg}")
        instance_variable_get("@#{arg}_history") << old_var unless old_var.nil?
        # задаем новое значение переменной
        instance_variable_set("@#{arg}", var)
      end
      # метод возвращающий массив истории изменения переменной
      define_method("#{arg}_history") { instance_variable_get("@#{arg}_history") }
    end
  end

  def strong_attr_acessor(arg, type)
      # getter
      define_method(arg) { instance_variable_get("@#{arg}") }
      # setter
      define_method("#{arg}=") do |var|
        raise "Несоответствие типов #{var.class} и #{type}" unless var.class == type
        instance_variable_set("@#{arg}", var)
      end
    end
end
