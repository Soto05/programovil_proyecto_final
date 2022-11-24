import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:meso_programovil_final/pages/usuarios/listarUsuario.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final elevatedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 226, 0, 0));
  final elevatednormalButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: const Color.fromARGB(255, 0, 226, 8));
  final elevatededitarButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color.fromARGB(255, 0, 106, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)));
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNivel = TextEditingController();

  //Le enviamos el estado del formulario, esta es la llave de validacion para que podamos ingresar esos datos
  final _formkey = GlobalKey<FormState>();

  void addData() {
    var url = Uri.parse('http://localhost:8080/PhpFluter/prueba/adddata.php');
    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": controllerNivel.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agregar Usuarios"),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerUsername,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese un Usuario";
                        },
                        decoration: const InputDecoration(
                          hintText: "Usuario",
                          labelText: "Usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerPassword,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese una contraseña";
                        },
                        decoration: const InputDecoration(
                          hintText: "Contraseña",
                          labelText: "Contraseña",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerNivel,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese un nivel";
                        },
                        decoration: const InputDecoration(
                          hintText: "Nivel",
                          labelText: "Nivel",
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    ElevatedButton(
                      style: elevatednormalButtonStyle,
                      child: const Text("Guardar"),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          addData();
                          //Todo:Agregar este registro y nos lleva a la pantalla principal osea a la pantalla anterior en donde estabamos
                          Navigator.pop(context);
                        }
                      },
                    ),
                    ElevatedButton(
                      style: elevatednormalButtonStyle,
                      child: const Text("Salir"),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/admin');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
