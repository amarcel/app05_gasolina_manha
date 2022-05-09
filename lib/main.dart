import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TelaGasolina(),
  ));
}

class TelaGasolina extends StatefulWidget {
  const TelaGasolina({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EstadoGasolina();
  }
} // fim de TelaGasolina

class EstadoGasolina extends State<TelaGasolina> {
  String modelo = '';
  double distancia = 0.0, potencia = 0.0, gasolina = 0.0;
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GasApp'),
      ),
      body: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Modelo do carro'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Erro! Informe o modelo do carro';
                } else {
                  modelo = value;
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Distância (km)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Erro! Informe a distância percorrida';
                } else {
                  distancia = double.parse(value);
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Potência do motor'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Erro! Informe a potência';
                } else {
                  potencia = double.parse(value);
                  return null;
                }
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Valor do litro da gasolina'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Erro! Informe o valor do litro da gasolina';
                } else {
                  gasolina = double.parse(value);
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_form.currentState!.validate()) {
            setState(() {
              print('AQUI!');
            });
          }
        },
        child: const Text('Calcular'),
      ),
    );
  }
} // fim de EstadoGasolina
