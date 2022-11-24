import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../widgets/side_bar_widget.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final elevatedOscuro2ButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff2a2627));
  TextEditingController controllerNombre = TextEditingController();

  //Le enviamos el estado del formulario, esta es la llave de validacion para que podamos ingresar esos datos
  final _formkey = GlobalKey<FormState>();

  void addData() {
    var url = Uri.parse(
        'http://localhost:8080/PhpFluter/prueba/adddataCategoria.php');
    http.post(url, body: {
      "nombre": controllerNombre.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff005C38),
          centerTitle: true,
          elevation: 5.0,
          title: const Text("Agregar categoria"),
        ),
        drawer: const SideBarWidget(),
        body: Container(
          color: const Color(0xfff0eadc),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Column(
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
                            controller: controllerNombre,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese una Categoria";
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
                        height: 20.0,
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
                                Navigator.pop(context);
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
                                  context, '/listarCategoria');
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
