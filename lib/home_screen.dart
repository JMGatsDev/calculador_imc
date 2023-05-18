import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 18.6) {
      _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 40) {
      _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              return _resetFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(
              Icons.person,
              size: 120,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: weightController,
              decoration: const InputDecoration(
                labelText: "Peso (kG)",
                labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              validator: (value) {
                if (value!.isEmpty) {
                  return " Insira seu Peso!";
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: heightController,
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Insira seu altura!";
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
                child: const Text("Calcular"),
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    return _calculate();
                  }
                }),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            )
          ]),
        ),
      ),
    );
  }
}
