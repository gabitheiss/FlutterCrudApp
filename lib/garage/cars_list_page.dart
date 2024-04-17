import 'package:aula_flutter_app/todo/todo.dart';
import 'package:aula_flutter_app/todo/todo_service.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'garage_service.dart';

class CarsListPage extends StatefulWidget {
  const CarsListPage({super.key});

  @override
  State<CarsListPage> createState() {
    return _CarsListPageState();
  }
}

class _CarsListPageState extends State<CarsListPage> {
  List<Car> _cars = GarageService.instance.cars;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Carros'),
      ),
      body: ListView.builder(
        itemCount: _cars.length,
        itemBuilder: (context, index) {
          Car currentCar = _cars[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/form', arguments: currentCar)
                  .then((value) {
                setState(() {
                  _cars = GarageService.instance.cars;
                });
              });
            },
            child: ListTile(
              title: Text(currentCar.brand),
              subtitle: Text(currentCar.model),
              trailing: Text(currentCar.banner),
              leading: Text(currentCar.year),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed("/form").then((value) {
            setState(() {
              _cars = GarageService.instance.cars;
            });
          });
        },
        child: const Icon(Icons.car_crash_sharp),
      ),
    );
  }
}
