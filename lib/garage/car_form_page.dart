import 'package:flutter/material.dart';

import 'car.dart';
import 'garage_service.dart';

class CarFormPage extends StatefulWidget {
  const CarFormPage({super.key});

  @override
  State<CarFormPage> createState() {
    return _CarFormPageState();
  }
}

class _CarFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _bannerController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  int _id = GarageService.instance.nextID();
  Car? car;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null) {
        car = ModalRoute.of(context)!.settings.arguments as Car;
        setState(() {
          _modelController.text = car!.model;
          _brandController.text = car!.brand;
          _bannerController.text = car!.banner;
          _yearController.text = car!.year;
          _colorController.text = car!.color;
          _id = car!.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(car != null ? car!.model : "Cadastro de Carros"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(labelText: "Marca"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a marca do carro';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _modelController,
                      decoration: const InputDecoration(labelText: "Modelo"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o modelo do carro';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _bannerController,
                      decoration: const InputDecoration(labelText: "Placa"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a placa do carro';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(labelText: "Cor"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a cor do carro';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _yearController,
                      decoration: const InputDecoration(labelText: "Ano"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o ano do carro';
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Car car = Car(
                                id: _id,
                                banner: _bannerController.text,
                                brand: _brandController.text,
                                model: _modelController.text,
                                color: _colorController.text,
                                year: _yearController.text);
                            GarageService.instance.save(car);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
