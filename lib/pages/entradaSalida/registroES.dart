import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/side_bar_widget.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  // void initState() {
  //   var categorias
  //   super.initState();

  // }
  final elevatedOscuro2ButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff2a2627));

  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
  TextEditingController controllerEntradaSalida = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerDestino = TextEditingController();
  TextEditingController controllerIdMat = TextEditingController();

  //Le enviamos el estado del formulario, esta es la llave de validacion para que podamos ingresar esos datos
  final _formkey = GlobalKey<FormState>();

  void addData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/adddataEntradaSalida.php');
    http.post(url, body: {
      "fecha": controllerFecha.text,
      "cantidad": controllerCantidad.text,
      "entrada_salida": controllerEntradaSalida.text,
      "nombre": controllerNombre.text,
      "destino": controllerDestino.text,
      "idmat": controllerIdMat.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff005C38),
          centerTitle: true,
          elevation: 20.0,
          title: const Text('Registrar entrada o salida?'),
        ),
        drawer: const SideBarWidget(),
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
                        keyboardType: TextInputType.number,
                        controller: controllerFecha,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese una fecha";
                        },
                        decoration: const InputDecoration(
                          hintText: '0000/00/00',
                          labelText: "Fecha",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerCantidad,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese una cantidad";
                        },
                        decoration: const InputDecoration(
                          hintText: "Cantidad",
                          labelText: "Cantidad",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerEntradaSalida,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Ingrese 'entrada' o 'salida'";
                        },
                        decoration: const InputDecoration(
                          hintText: "Entrada o salida?",
                          labelText: "Entrada o salida?",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerNombre,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Ingrese el nombre de la persona quien lo recibe";
                        },
                        decoration: const InputDecoration(
                          hintText: "Nombre quien recibio",
                          labelText: "Nombre quien recibio",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerDestino,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese destino";
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Destino",
                          labelText: "Destino",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerIdMat,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese material";
                        },
                        decoration: const InputDecoration(
                          hintText: "Material",
                          labelText: "Material",
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: elevatedOscuro2ButtonStyle,
                          child: const Text("Guardar"),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              addData();
                              //Todo:Agregar este registro y nos lleva a la pantalla principal osea a la pantalla anterior en donde estabamos
                              Navigator.pushReplacementNamed(
                                  context, '/listarEntradaSalida');
                            }
                          },
                        ),
                        Container(
                          width: 30,
                        ),
                        ElevatedButton(
                          style: elevatedOscuro2ButtonStyle,
                          child: const Text("    Salir    "),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/listarEntradaSalida');
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
