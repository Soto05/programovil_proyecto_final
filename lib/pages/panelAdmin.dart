import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opciones"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/listarUsuario');
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: const Icon(
                      Icons.people,
                      color: Colors.blueAccent,
                      size: 73,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/listarCategoria');
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: const Icon(
                      Icons.list,
                      color: Colors.blueAccent,
                      size: 73,
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/listarMaterial');
                      },
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: const Icon(
                        Icons.shower,
                        color: Colors.blueAccent,
                        size: 73,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      },
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: const Icon(
                        Icons.exit_to_app,
                        color: Colors.redAccent,
                        size: 73,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
