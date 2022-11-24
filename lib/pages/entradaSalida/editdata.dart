import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:meso_programovil_final/pages/entradaSalida/listarES.dart';
import '../../widgets/side_bar_widget.dart';

const List<String> list = <String>[
  'Lapiceros',
  'Cuadernos',
  'Playeras',
  'Botones',
  'Trifoliares',
  'Libros',
  'Discos',
  'Llaveros',
  'Papeletas',
  'Lapices',
  'Pachones',
  'Borradores',
];
String dropdownValue = list.first;

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
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
  TextEditingController controllerEntradaSalida = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerDestino = TextEditingController();
  TextEditingController controllerIdMat = TextEditingController();

  Future<List> getData() async {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/getdataEntradaSalida.php');
    var response = await http.get(url);
    var respuesta;
    respuesta = json.decode(response.body);
    print(respuesta);
    return json.decode(response.body);
  }

  void editData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/editdataEntradasSalida.php');
    http.post(url, body: {
      "idEntradaSalida": widget.list[widget.index]['idEntradaSalida'],
      "fecha": controllerFecha.text,
      "cantidad": controllerCantidad.text,
      "entrada_salida": controllerEntradaSalida.text,
      "nombre": controllerNombre.text,
      "destino": controllerDestino.text,
      "idmat": controllerIdMat.text,
    });
  }

  @override
  void initState() {
    //!Esta propiedad significa "Cuando cargue la aplicacion"
    controllerFecha =
        TextEditingController(text: widget.list[widget.index]['fecha']);
    controllerCantidad =
        TextEditingController(text: widget.list[widget.index]['cantidad']);
    controllerEntradaSalida = TextEditingController(
        text: widget.list[widget.index]['entrada_salida']);
    controllerNombre =
        TextEditingController(text: widget.list[widget.index]['nombre']);
    controllerDestino =
        TextEditingController(text: widget.list[widget.index]['destino']);
    controllerIdMat =
        TextEditingController(text: widget.list[widget.index]['idmat']);

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff005C38),
        centerTitle: true,
        elevation: 5.0,
        title: const Text("Editar entradas o salidas"),
      ),
      drawer: const SideBarWidget(),
      body: Form(
        //!Form nos va ayudar para hacer las validaciones automaticamente si se escribio bien o falta algo en una entrada, entre otras cosas
        child: Container(
          color: const Color(0xfff0eadc),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              Container(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerFecha,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una fecha";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.description),
                        hintText: "Fecha",
                        labelText: "Fecha",
                        border: InputBorder.none),
                  )),
              Container(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerCantidad,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una cantidad";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(FontAwesomeIcons.arrowUpWideShort),
                        hintText: "Cantidad",
                        labelText: "Cantidad",
                        border: InputBorder.none),
                  )),
              Container(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerEntradaSalida,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese entrada o salida?";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_month),
                        hintText: "Entrada o salida?",
                        labelText: "Entrada o salida?",
                        border: InputBorder.none),
                  )),
              Container(
                height: 10,
              ),
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
                        return "Ingrese nombre quien lo recibio";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.install_desktop_outlined),
                        hintText: "Nombre quien recibio",
                        labelText: "Nombre quien recibio",
                        border: InputBorder.none),
                  )),
              Container(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerDestino,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese destino";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.output_outlined),
                        hintText: "Destino",
                        labelText: "Destino",
                        border: InputBorder.none),
                  )),
              Container(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: combo(),
              ),
              Container(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerIdMat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese el material";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(FontAwesomeIcons.shapes),
                        hintText: "Material",
                        labelText: "Material",
                        border: InputBorder.none),
                  )),
              Container(
                height: 20,
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
                        builder: (BuildContext context) => const ListarES()));
                  },
                  child: const Text("Guardar"))
            ],
          ),
        ),
      ),
    );
  }

  SizedBox combo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 26,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.green)),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconEnabledColor: Colors.green,
            isExpanded: true,
            elevation: 16,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.shapes,
                          color: Colors.grey[600]!,
                        ),
                        Text("    $value"),
                      ],
                    ),
                  ));
            }).toList(),
          )),
    );
  }
}
