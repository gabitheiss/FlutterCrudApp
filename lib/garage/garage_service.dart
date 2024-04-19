import 'car.dart';

class GarageService {
  GarageService._();

  List<Car> _cars = [];

  int _id = 0;

  static final instance = GarageService._();

  int nextID() {
    return _id++;
  }

  save(Car car) {
    var data = _cars.where((element) => element.banner == car.banner);
    if (data.isEmpty) {
      _cars.add(car);
    } else {
      _cars = _cars.map((element) {
        if (element.banner == car.banner) {
          return car;
        }
        return element;
      }).toList();
    }
  }

  delete(Car car) {
    var data = _cars.where((element) => element.banner == car.banner);
    if (data.isNotEmpty) {
      _cars.removeWhere((element) => element.banner == car.banner);
    }
  }

  List<Car> get cars => _cars;
}
