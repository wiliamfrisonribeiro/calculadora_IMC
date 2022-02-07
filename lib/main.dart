import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.green),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFileds() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {});
    weightController.text = "";
    heightController.text = "";
    _infoText = "Informe seus dados!";
    _formKey = GlobalKey<FormState>();
  }

  void _calculate() {
    FocusManager.instance.primaryFocus?.unfocus();
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    if (imc < 18.6) {
      _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
    } else if (imc > 18.6 && imc < 24.9) {
      _infoText = "Normal (${imc.toStringAsPrecision(3)})";
    } else if (imc > 25.0 && imc < 29.9) {
      _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
    } else if (imc > 30.0 && imc < 39.9) {
      _infoText = "Obesidade (${imc.toStringAsPrecision(3)})";
    } else {
      _infoText = "Obesidade Grave (${imc.toStringAsPrecision(3)})";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(onPressed: _resetFileds, icon: Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu Peso";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style:const TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua Altura";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _calculate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green, onPrimary: Colors.white),
                          child: const Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
