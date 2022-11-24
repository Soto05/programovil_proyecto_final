import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/categoria/listarCategoria.dart';

import '../../widgets/side_bar_widget.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;
  const EditData({super.key, required this.list, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final elevatedOscuro2ButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff2a2627));
  TextEditingController controllerNombre = TextEditingController();

  void editData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/editdataCategoria.php');
    http.post(url, body: {
      "idCategoria": widget.list[widget.index]['idCategoria'],
      "nombre": controllerNombre.text,
    });
  }

  @override
  void initState() {
    //!Esta propiedad significa "Cuando cargue la aplicacion"
    controllerNombre =
        TextEditingController(text: widget.list[widget.index]['nombre']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff005C38),
        centerTitle: true,
        elevation: 20.0,
        title: const Text("Editar categoria"),
      ),
      drawer: const SideBarWidget(),
      body: Form(
        //!Form nos va ayudar para hacer las validaciones automaticamente si se escribio bien o falta algo en una entrada, entre otras cosas
        child: Container(
          color: const Color(0xfff0eadc),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerNombre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese un nombre de categoria";
                      }
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(FontAwesomeIcons.shapes),
                        hintText: "Categoria",
                        labelText: "Categoria",
                        border: InputBorder.none),
                  )),
              Container(
                height: 20.0,
              ),
              const Divider(
                height: 1.0,
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                  style: elevatedOscuro2ButtonStyle,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ListarCategoria()));
                  },
                  child: const Text("Guardar"))
            ],
          ),
        ),
      ),
    );
  }
}
