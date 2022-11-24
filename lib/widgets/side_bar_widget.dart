import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../pages/material_descripcion.dart';
// import '../pages/products_page.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff005C38),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Logo-Meso-Color.png',
                  width: 120,
                  height: 120,
                ),
              ],
            ),
          ),
          // ListTile(
          //   leading: const Icon(FontAwesomeIcons.house),
          //   title: const Text(
          //     'Inicio',
          //     textScaleFactor: 1.3,
          //   ),
          //   textColor: const Color(0xff2a2627),
          //   onTap: () {
          //     // Navigator.of(context).push(MaterialPageRoute(
          //     //   builder: (context) => ListarCategoria(),
          //     // ));
          //   },
          // ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.shapes),
            title: const Text(
              'Categoría',
              textScaleFactor: 1.3,
            ),
            textColor: const Color(0xff2a2627),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/listarCategoria');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.laptopFile),
            title: const Text(
              'Materiales',
              textScaleFactor: 1.3,
            ),
            textColor: const Color(0xff2a2627),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/listarMaterial');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.paperPlane),
            title: const Text(
              'Entradas y Salidas',
              textScaleFactor: 1.3,
            ),
            textColor: const Color(0xff2a2627),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/listarEntradaSalida');
            },
          ),
        ],
      ),
    );
  }
}
