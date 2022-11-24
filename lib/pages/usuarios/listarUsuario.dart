import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/usuarios/details.dart';
import 'package:meso_programovil_final/pages/usuarios/registroUsuarios.dart';

import 'dart:async';
import 'dart:convert';

class ListarUsuario extends StatefulWidget {
  const ListarUsuario({super.key});

  @override
  State<ListarUsuario> createState() => _ListarUsuarioState();
}

class _ListarUsuarioState extends State<ListarUsuario> {
  Future<List> getData() async {
    var url = Uri.parse('http://localhost:8080/PhpFluter/prueba/getdata.php');
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Usuarios"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AddData(),
          ));
        },
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<List>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ItemList(
                          list: snapshot.data!,
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/admin'),
            child: const Text(
              "Regresar",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: Card(
              color: Color.fromARGB(255, 88, 0, 252),
              child: ListTile(
                title: Text(
                  list[i]['username'],
                  style: const TextStyle(
                      fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: const Icon(
                  Icons.person_pin,
                  size: 77.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: Text(
                  "Nivel: ${list[i]['nivel']}",
                  style: const TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
