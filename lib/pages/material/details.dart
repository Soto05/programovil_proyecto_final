import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/material/listarMaterial.dart';
import 'package:meso_programovil_final/pages/material/editdata.dart';

import '../../widgets/side_bar_widget.dart';

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
    backgroundColor: const Color(0xff005C38),
  );
  final elevatednormalButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: const Color(0xfff0eadc));
  final elevatedOscuro2ButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff2a2627));
  final elevatededitarButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff99999b));

  void deleteData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/deleteDataMaterial.php');
    //Aqui enviamos el parametro que es el id del registro que vamos a eliminar
    http.post(url,
        body: {'idMaterial': widget.list[widget.index]['idMaterial']});
  }

  //!Un mensaje si realmente queremos eliminar el archivo
  void ReallyDelete() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Color(0xfff0eadc),
      // shape: CircleBorder(),
      content: Text(
          "Seguro desea eliminar '${widget.list[widget.index]['descripcion']}'"),
      actions: <Widget>[
        ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ListarMaterial()));
          },
          child: const Text(
            "Eliminar",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: elevatededitarButtonStyle,
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
      backgroundColor: Color(0xfff0eadc),
      appBar: AppBar(
        backgroundColor: Color(0xff005C38),
        centerTitle: true,
        elevation: 20.0,
        title: const Text("Material"),
      ),
      drawer: const SideBarWidget(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Card(
            color: Color(0xff99999b),
            child: Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Text(
                    widget.list[widget.index]['descripcion'],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        style: elevatedOscuro2ButtonStyle,
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
                        style: elevatedOscuro2ButtonStyle,
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
      ),
    );
  }
}
