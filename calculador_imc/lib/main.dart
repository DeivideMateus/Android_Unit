import 'package:calculador_imc/login.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora Imc",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Loader()
    );
  }
}



