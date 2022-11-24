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

  TextEditingController controllerDescripcion = TextEditingController();
  TextEditingController controllerCantidadExistente = TextEditingController();
  TextEditingController controllerAnio = TextEditingController();
  TextEditingController controllerTotalEntradas = TextEditingController();
  TextEditingController controllerTotalSalidas = TextEditingController();
  TextEditingController controllerIdCat = TextEditingController();

  //Le enviamos el estado del formulario, esta es la llave de validacion para que podamos ingresar esos datos
  final _formkey = GlobalKey<FormState>();

  void addData() {
    var url =
        Uri.parse('http://localhost:8080/PhpFluter/prueba/adddataMaterial.php');
    http.post(url, body: {
      "descripcion": controllerDescripcion.text,
      "cantidadExistente": controllerCantidadExistente.text,
      "anio": controllerAnio.text,
      "totalEntradas": controllerTotalEntradas.text,
      "totalSalidas": controllerTotalSalidas.text,
      "idCat": controllerIdCat.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff005C38),
          centerTitle: true,
          elevation: 20.0,
          title: const Text('Material'),
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
                        controller: controllerDescripcion,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese una descripción";
                        },
                        decoration: const InputDecoration(
                          hintText: "Descripción",
                          labelText: "Descripción",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerCantidadExistente,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Ingrese una cantidad existente";
                        },
                        decoration: const InputDecoration(
                          hintText: "Cantidad existente",
                          labelText: "Cantidad existente",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerAnio,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese año";
                        },
                        decoration: const InputDecoration(
                          hintText: "Año",
                          labelText: "Año",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerTotalSalidas,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese total de salidas";
                        },
                        decoration: const InputDecoration(
                          hintText: "Total de salidas",
                          labelText: "Total de salidas",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerTotalEntradas,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese total de entradas";
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Total de entradas",
                          labelText: "Total de entradas",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.black,
                      ),
                      title: TextFormField(
                        controller: controllerIdCat,
                        validator: (value) {
                          if (value!.isEmpty) return "Ingrese categoria";
                        },
                        decoration: const InputDecoration(
                          hintText: "Categoria",
                          labelText: "Categoria",
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
                                  context, '/listarMaterial');
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
                                context, '/listarMaterial');
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
