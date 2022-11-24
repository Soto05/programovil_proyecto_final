import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meso_programovil_final/pages/usuarios/listarUsuario.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;
  const EditData({super.key, required this.list, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
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
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNivel = TextEditingController();

  void editData() {
    var url = Uri.parse('http://localhost:8080/PhpFluter/prueba/editdata.php');
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": controllerNivel.text,
    });
  }

  @override
  void initState() {
    //!Esta propiedad significa "Cuando cargue la aplicacion"
    controllerUsername =
        TextEditingController(text: widget.list[widget.index]['username']);
    controllerPassword =
        TextEditingController(text: widget.list[widget.index]['password']);
    controllerNivel =
        TextEditingController(text: widget.list[widget.index]['nivel']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar"),
      ),
      body: Form(
        //!Form nos va ayudar para hacer las validaciones automaticamente si se escribio bien o falta algo en una entrada, entre otras cosas
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: TextFormField(
                controller: controllerUsername,
                validator: (value) {
                  if (value!.isEmpty) return "Ingrese un usuario";
                },
                decoration: const InputDecoration(
                    hintText: "Usuario", labelText: "Usuario"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              title: TextFormField(
                controller: controllerPassword,
                validator: (value) {
                  if (value!.isEmpty) return "Ingrese una contraseña";
                },
                decoration: const InputDecoration(
                    hintText: "Contraseña", labelText: "Contraseña"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.receipt_outlined,
                color: Colors.black,
              ),
              title: TextFormField(
                controller: controllerNivel,
                validator: (value) {
                  if (value!.isEmpty) return "Ingrese un nivel";
                },
                decoration: const InputDecoration(
                    hintText: "Nivel", labelText: "Nivel"),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
                style: elevatednormalButtonStyle,
                onPressed: () {
                  editData();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ListarUsuario()));
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
