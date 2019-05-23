import 'package:flutter/material.dart';

Widget buildTextFormField(
    String label, String validator, TextEditingController c) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label, labelStyle: TextStyle(color: Colors.green)),
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.green, fontSize: 25.0),
    controller: c,
    validator: (value) {
      if (value.isEmpty) {
        return validator;
      }
    },
  );
}

Widget buildText(String label) {
  return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
        ),
      )
  );
}

Widget buildTextPeso(double peso) {
  if(peso == null){
    peso = 0;
  }
  return Expanded(
      child:Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Text(
          "${peso.toStringAsPrecision(2)} Kg",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
        ),
      )
  );
}