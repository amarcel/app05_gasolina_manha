import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MaterialApp(
    home: const TelaGasolina(),
    initialRoute: '/inicio',
    routes: {
      '/inicio': (context) => const TelaGasolina(),
      '/resultado': (context) => TelaResultado()
    },
  ));
}

class Argumentos {
  String modelo = '';
  double distancia = 0.0, potencia = 0.0, gasolina = 0.0;
  double valorTotal = 0.0;
  Argumentos(this.modelo, this.distancia, this.potencia, this.gasolina,
      this.valorTotal);
} // fim de Argumentos

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
        // class EstadoGasolina
        onPressed: () {
          if (_form.currentState!.validate()) {
            setState(() {
              double valorTotal = 0.0;
              if (potencia <= 1.0) {
                valorTotal = (distancia / 13.0) * gasolina;
              } else if (potencia > 1.0 && potencia <= 1.4) {
                valorTotal = (distancia / 11.0) * gasolina;
              } else if (potencia > 1.4 && potencia <= 1.9) {
                valorTotal = (distancia / 9.50) * gasolina;
              } else if (potencia > 1.9) {
                valorTotal = (distancia / 7.75) * gasolina;
              }
              Navigator.pushNamed(context, '/resultado',
                  arguments: Argumentos(
                      modelo, distancia, potencia, gasolina, valorTotal));
            });
          }
        },
        child: const Text('Calcular'),
      ),
    );
  }
} // fim de EstadoGasolina

class TelaResultado extends StatefulWidget {
  const TelaResultado({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EstadoResultado();
  }
}

class EstadoResultado extends State<TelaResultado> {
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Argumentos;
    resultado =
        '${args.modelo} ${args.potencia} gasta R\$ ${args.valorTotal} para percorrer ${args.distancia} km com gasolina a R\$ ${args.gasolina} por litro';
    final box = context.findRenderObject() as RenderBox?;
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              resultado,
              style: const TextStyle(fontSize: 32),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () {
          setState(() {
            Share.share(resultado, subject: 'AppGas');
          });
        },
      ),
    );
  }
}
