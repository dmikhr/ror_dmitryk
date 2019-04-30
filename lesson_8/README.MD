- Добавлены идиомы из скринкаста
- В коде исправлены замечания автоматически через rubocop -a
- Вручную исправлены замечания, которые rubocop не исправил
\
.rubocop.yml - исключения и модификации параметров проверки в rubocop\
rubocop_report.log - результат проверки rubocop (*rubocop > rubocop_report.log*)\
main.rb - текстовый интерфейс\
command.rb - базовый класс Command реализующий функции в меню\
commandprompt.rb - модифицированный ввод данных с учетом обработки исключений при создании объекта Train\
production_company.rb - модуль, позволяющий указывать и получать название компании-производителя\
validation.rb - метод valid? - вынесен в отдельный модуль, т.к. его реализация во всех классах одинаковая\
instance_counter.rb - модуль InstanceCounter\
train.rb - базовый класс поезда Train\
cargo_train.rb - класс грузового поезда, подкласс Train\
passenger_train.rb - класс пассажирского поезда, подкласс Train\
carriage.rb - базовый класс вагона Carriage\
cargo_carriage.rb - класс грузового вагона, подкласс Carriage\
passenger_carriage.rb - класс пассажирского вагона, подкласс Carriage\
route.rb - реализация класса Route\
station.rb - реализация класса Station\
test1.rb - тестирование новых методов в классах PassengerCarriage, CargoCarriage, Station, Train\
test2.rb - вывод информации о поездах на станциях и вагонах у поездов
