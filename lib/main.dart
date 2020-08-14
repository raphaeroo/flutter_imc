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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    heightController.text = "";
    weightController.text = "";

    setState(() {
      _formKey = GlobalKey<FormState>();
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Dados Inválidos";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green[900],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _resetFields();
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Icon(Icons.person_outline,
                          size: 120, color: Colors.green[900])),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Insira seu Peso!";
                          }
                          return null;
                        },
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso (kg)",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            labelStyle: TextStyle(color: Colors.green[900])),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.green[900], fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Insira sua Altura!";
                          }
                          return null;
                        },
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green[900], width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            labelStyle: TextStyle(color: Colors.green[900])),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.green[900], fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          color: Colors.green[900]),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[900], fontSize: 16),
                  )
                ],
              ),
            )));
  }
}
