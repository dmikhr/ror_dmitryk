module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      # getter
      define_method(arg) { instance_variable_get("@#{arg}") }
      # setter
      define_method("#{arg}=") do |var|
        # задаем значение переменной
        instance_variable_set("@#{arg}", var)
        # если массив историй значений переменной не существовал - создаем его
        instance_variable_set("@#{arg}_history", []) if instance_variable_get("@#{arg}_history").nil?
        # добавляем значение в массив
        # https://stackoverflow.com/questions/46896904/push-element-to-dynamic-array-created-with-instance-variable-set-in-rails
        instance_variable_get("@#{arg}_history") << var
      end
      # метод возвращающий массив истории изменения переменной
      define_method("#{arg}_history") { instance_variable_get("@#{arg}_history") }
    end
  end

  def strong_attr_acessor(*args)
    args.each do |arg|
      # getter
      define_method(arg) { instance_variable_get("@#{arg}") }
      # setter
      define_method("#{arg}=") do |var|
        raise "Несоответствие типов #{var[0].class} и #{var[1]}" unless var[0].class == var[1]
        instance_variable_set("@#{arg}", var[0])
      end
    end
  end
end
