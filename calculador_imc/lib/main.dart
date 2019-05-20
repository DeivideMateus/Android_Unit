import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";
  String _pesoIdeal = "";

  void _resetarCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _pesoIdeal = "";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      } else if (imc > 39.9) {
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
      }
      double pesoIdeal1 = 18.6 * (altura * altura);
      double pesoIdeal2 = 24.8 * (altura * altura);
      _pesoIdeal =
          "Seu peso ideal é entre ${pesoIdeal1.toStringAsPrecision(2)} e "
              "${pesoIdeal2.toStringAsPrecision(2)} Kg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                buildTextFormField("Peso (kg)", "Insira seu peso", pesoController),
                buildTextFormField("Altura (cm)", "Insira sua altura", alturaController),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _pesoIdeal,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}

Widget buildTextFormField(String label, String validator, TextEditingController c){
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green)),
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
