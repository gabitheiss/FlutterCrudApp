import 'package:flutter/material.dart';

import 'garage/car_form_page.dart';
import 'garage/cars_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black38),
      routes: {
        "/": (context) => const CarsListPage(),
        "/form": (context) => const CarFormPage()
      },
    );
  }
}
