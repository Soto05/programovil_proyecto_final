import 'package:flutter/material.dart';

class TipoPage extends StatelessWidget {
  const TipoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagina de tipo'),
        ),
        body: Column(
          children: <Widget>[
            const Text('Pagina de incio'),
            ElevatedButton(
                child: const Text("Salir"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/LoginPage');
                })
          ],
        ));
  }
}
