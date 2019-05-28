import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calculador_imc/Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print("Singned in: ${user.uid}");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } 
        else {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _email, password: _password);
          print("Usuário registrado: ${user.uid}");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(hintText: "E-mail"),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? "Email inválido" : null,
        onSaved: (value) => _email = value,
      ),
      SizedBox(
        height: 16.0,
      ),
      TextFormField(
        decoration: InputDecoration(hintText: "Senha"),
        obscureText: true,
        validator: (value) => value.isEmpty ? "Senha invalida" : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          color: Colors.green,
          onPressed: validateAndSubmit,
        ),
        RaisedButton(
          child: Text(
            "Criar conta",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          color: Colors.green,
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            "Criar conta",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          color: Colors.green,
          onPressed: validateAndSubmit,
        ),
        RaisedButton(
          child: Text(
            "Possui uma conta? Faça Login",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          color: Colors.green,
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
