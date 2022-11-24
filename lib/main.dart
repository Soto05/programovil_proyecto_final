import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meso_programovil_final/pages/usuarios/listarUsuario.dart';
import 'package:meso_programovil_final/pages/categoria/listarCategoria.dart';
import 'package:meso_programovil_final/pages/example/tipo.dart';
import 'package:meso_programovil_final/pages/panelAdmin.dart';
import 'package:meso_programovil_final/pages/entradaSalida/listarES.dart';
import 'package:meso_programovil_final/pages/material/listarMaterial.dart';
import 'package:http/http.dart' as http;

//VISTAS
// import 'package:meso_programovil_final/views/responsive/desktop_scaffold.dart';
// import 'package:meso_programovil_final/views/responsive/mobile_scaffold.dart';
// import 'package:meso_programovil_final/views/responsive/responsive_layout.dart';
// import 'package:meso_programovil_final/views/responsive/tablet_scaffold.dart';

void main() {
  runApp(const MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mesoamericana',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: <String, WidgetBuilder>{
          '/LoginPage': (BuildContext context) => const LoginPage(),
          //Usuarios
          '/listarUsuario': (BuildContext context) => const ListarUsuario(),
          //Categoria
          '/listarCategoria': (BuildContext context) => const ListarCategoria(),
          //EntradaSalidas
          '/listarEntradaSalida': (BuildContext context) => const ListarES(),
          //Material
          '/listarMaterial': (BuildContext context) => const ListarMaterial(),
          '/tipo': (BuildContext context) => const TipoPage(),
          '/admin': (BuildContext context) => const AdminPage(),
        });
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xff005C38),
  );
  final elevatednormalButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: const Color(0xfff0eadc));
  final elevatedOscuro2ButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff2a2627));
  final elevatededitarButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xff99999b),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)));
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  // Si se loguean correctamente se enviara el siguiente mensaje

  String mensaje = '';

  // Vamos a usar la propiedad future y le pasaremos el listado
  Future<List> _login() async {
    // var url = "http://192.168.1.8/PhpFluter/prueba/login.php";
    // return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    var url = Uri.parse('http://localhost:8080/PhpFluter/prueba/login.php');
    var response = await http.post(url, body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });
    // }

    //Esta linea quiere decir que la consulta del login con todos nuestros usuarios lo almacen en responsive
    var datauser = json.decode(response.body);
    //Si no se obtiene ninguno registro es porque no hace coincidencia ninguno con los datos de la tabla
    if (datauser.length == 0) {
      setState(() {
        mensaje = "Usuario o contraseña incorrectas";
      });
    } else {
      //Sino entra al sistema y dependiendo de su nivel nos va a tirar a una pagina
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/listarCategoria');
      } else if (datauser[0]['nivel'] == 'ventas') {
        Navigator.pushReplacementNamed(context, '/vendedores');
      }
      setState(() {
        //Envia el vamor que tiene la variable username
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //!Este es el diseño
        resizeToAvoidBottomInset: false,
        body: Form(
          //! ignore: avoid_unnecessary_containers
          child: Container(
            // !Para agregar imagen de fondo
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage("assets/images/fondo.jpg"),
            //       fit: BoxFit.cover),
            // ),
            child: Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.only(top: 50.0),
                //   child: const CircleAvatar(
                //     backgroundColor: Color.fromARGB(255, 0, 232, 77),
                //     backgroundImage:
                //         AssetImage("assets/images/Logo-Meso-Color.png"),
                //   ),
                //   width: 300.0,
                //   height: 300.0,
                //   decoration: const BoxDecoration(
                //     // Aquie le podemos dar circulo o cuadrado
                //     shape: BoxShape.rectangle,
                //   ),
                // ),

                //! Logo de la meso
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/images/Logo-Meso-Color.png',
                      height: 200.0,
                      width: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  //! Otra seccion
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      // ! Aqui creamos las cajas donde va el usuario
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 25)
                            ]),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: controllerUser,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: 'Ingrese usuario',
                            ),
                          ),
                        ),
                      ),
                      Container(height: 20),
                      // ! Aqui creamos las cajas donde va el contraseña
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 25)
                            ]),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            //todo Es el controller es donde capturamos la informacion
                            controller: controllerPass,
                            //*Para ocultar lo que escribimos
                            obscureText: true,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Ingrese contraseña',
                            ),
                          ),
                        ),
                      ),
                      //?
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            right: 45,
                          ),
                          child: Text(
                            'Recordar contraseña',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      //?
                      const Spacer(),
                      ElevatedButton(
                          style: elevatednormalButtonStyle,
                          onPressed: () {
                            _login();
                          },
                          child: const Text('Ingresar')),
                      Container(
                        height: 20,
                      ),
                      //! Si esta incorrecto el usuario y la contraseña
                      Text(
                        mensaje,
                        style:
                            const TextStyle(fontSize: 15.0, color: Colors.red),
                      )
                    ],
                  ),
                ),
                // !La otra caja
              ],
            ),
          ),
        ));
  }
}
