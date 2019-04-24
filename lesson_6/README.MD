Валидация добавлена в базовые классы Train, Station, Route, Carriage\
\
validation.rb - метод valid? - вынесен в отдельный модуль, т.к. его реализация во всех классах одинаковая\
train_interface.rb - текстовый интерфейс для создания поездов\
production_company.rb - модуль, позволяющий указывать и получать название компании-производителя\
instancecounter.rb - модуль InstanceCounter\
train.rb - базовый класс поезда Train\
cargo_train.rb - класс грузового поезда, подкласс Train\
passenger_train.rb - класс пассажирского поезда, подкласс Train\
carriage.rb - базовый класс вагона Carriage\
cargo_carriage.rb - класс грузового вагона, подкласс Carriage\
passenger_carriage.rb - класс пассажирского вагона, подкласс Carriage\
route.rb - реализация класса Route\
station.rb - реализация класса Station\
test.rb - тестирование функционала
