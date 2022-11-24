import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/usuarios/listarUsuario.dart';
import 'package:meso_programovil_final/pages/usuarios/editdata.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  const Detail({super.key, required this.list, required this.index});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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

  void deleteData() {
    var url =
        Uri.parse('http://localhost:8080/PhpFluter/prueba/deleteData.php');
    //Aqui enviamos el parametro que es el id del registro que vamos a eliminar
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  //!Un mensaje si realmente queremos eliminar el archivo
  void ReallyDelete() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.amber,
      // shape: CircleBorder(),
      content: Text(
          "Seguro desea eliminar '${widget.list[widget.index]['username']}'"),
      actions: <Widget>[
        ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ListarUsuario()));
          },
          child: const Text(
            "Eliminar",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: elevatednormalButtonStyle,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['username']}"),
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.green.shade200,
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.list[widget.index]['username'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                const Divider(),
                Text(
                  "Nivel : ${widget.list[widget.index]['nivel']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      style: elevatededitarButtonStyle,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                      child: const Text("Editar"),
                    ),
                    const VerticalDivider(),
                    ElevatedButton(
                      style: elevatededitarButtonStyle,
                      onPressed: () => ReallyDelete(),
                      child: const Text("Eliminar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
