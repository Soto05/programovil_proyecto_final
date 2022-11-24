import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/material/details.dart';
import 'package:meso_programovil_final/pages/material/registroMaterial.dart';

import 'dart:async';
import 'dart:convert';

import '../../widgets/side_bar_widget.dart';

class ListarMaterial extends StatefulWidget {
  const ListarMaterial({super.key});

  @override
  State<ListarMaterial> createState() => _ListarMaterialState();
}

class _ListarMaterialState extends State<ListarMaterial> {
  final elevatedButtonStyleVerde = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff005C38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)));

  Future<List> getData() async {
    var url =
        Uri.parse('http://localhost:8080/PhpFluter/prueba/getdataMaterial.php');
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff005C38),
        centerTitle: true,
        elevation: 20.0,
        title: const Text('Materiales'),
      ),
      drawer: const SideBarWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2a2627),
        elevation: 15.0,
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
            height: MediaQuery.of(context).size.height * 0.85,
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
            style: elevatedButtonStyleVerde,
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
  const ItemList({super.key, required this.list});

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
              color: const Color(0xfff0eadc),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Text(
                      "Cantidad existente: ${list[i]['cantidadExistente']}",
                    ),
                    leading: const Icon(FontAwesomeIcons.hammer),
                  ),
                  const Divider(),
                  ListTile(
                    title: Column(
                      children: [
                        Text(
                          "Descripción: ${list[i]['descripcion']}",
                        ),
                        Text(
                          "Año: ${list[i]['anio']}",
                        ),
                        Container(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Entradas: ${list[i]['totalEntradas']}"),
                            Text("Salidas: ${list[i]['totalSalidas']}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () => {},
                          child: const Text('Mostrar')),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
