import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/material/listarMaterial.dart';
import 'dart:async';
import 'dart:convert';
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
  TextEditingController controllerDescripcion = TextEditingController();
  TextEditingController controllerCantidadExistente = TextEditingController();
  TextEditingController controllerAnio = TextEditingController();
  TextEditingController controllerTotalEntradas = TextEditingController();
  TextEditingController controllerTotalSalidas = TextEditingController();
  TextEditingController controllerIdCat = TextEditingController();

  Future<List> getData() async {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/getdataCategoria.php');
    var response = await http.get(url);
    var respuesta;
    respuesta = json.decode(response.body);
    print(respuesta);
    return json.decode(response.body);
  }

  void editData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/editdataMaterial.php');
    http.post(url, body: {
      "idMaterial": widget.list[widget.index]['idMaterial'],
      "descripcion": controllerDescripcion.text,
      "cantidadExistente": controllerCantidadExistente.text,
      "anio": controllerAnio.text,
      "totalEntradas": controllerTotalEntradas.text,
      "totalSalidas": controllerTotalSalidas.text,
      "idCat": controllerIdCat.text,
    });
  }

  @override
  void initState() {
    //!Esta propiedad significa "Cuando cargue la aplicacion"
    controllerDescripcion =
        TextEditingController(text: widget.list[widget.index]['descripcion']);
    controllerCantidadExistente = TextEditingController(
        text: widget.list[widget.index]['cantidadExistente']);
    controllerAnio =
        TextEditingController(text: widget.list[widget.index]['anio']);
    controllerTotalEntradas =
        TextEditingController(text: widget.list[widget.index]['totalEntradas']);
    controllerTotalSalidas =
        TextEditingController(text: widget.list[widget.index]['totalSalidas']);
    controllerIdCat =
        TextEditingController(text: widget.list[widget.index]['idCat']);

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
        title: const Text("Editar material"),
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
                    controller: controllerDescripcion,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una descripción";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.description),
                        hintText: "Descripción",
                        labelText: "Descripción",
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
                    controller: controllerCantidadExistente,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una cantidad";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(FontAwesomeIcons.arrowUpWideShort),
                        hintText: "Cantidad existente",
                        labelText: "Cantidad existente",
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
                    controller: controllerAnio,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese un año";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_month),
                        hintText: "Año",
                        labelText: "Año",
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
                    controller: controllerTotalEntradas,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese un total de entradas";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.install_desktop_outlined),
                        hintText: "Total de entradas",
                        labelText: "Total de entradas",
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
                    controller: controllerTotalSalidas,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese un total de salidas";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.output_outlined),
                        hintText: "Total de salidas",
                        labelText: "Total de salidas",
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
                    controller: controllerIdCat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una categoria";
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        icon: Icon(FontAwesomeIcons.shapes),
                        hintText: "Categoria",
                        labelText: "Categoria",
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
                        builder: (BuildContext context) =>
                            const ListarMaterial()));
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
