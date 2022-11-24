import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meso_programovil_final/views/responsive/constants.dart';

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

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  var fechaMask = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var cantidadMask =
      MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myDefaultBackground,
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.network(
              "http://www.mesoamericana.edu.gt/wp-content/uploads/2012/01/Logo-Un-Color.png",
              height: 150,
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('NOMBRE DEL PROVEEDOR:'),
            inputProveedor(),
            const SizedBox(
              height: 10,
            ),
            const Text('CANTIDAD DE PRODUCTO: '),
            inputCantidad(),
            const SizedBox(
              height: 10,
            ),
            const Text('FECHA DE RECIBIDO: '),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: inputFecha(),
                ),
              ],
            ),
            const Text('ELIJA UNA CATEGORÍA'),
            SizedBox(
              width: 250,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  child: combo()),
            ),
            //Boton Guardar
            Container(
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width - 30,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('GUARDAR')))
          ],
        ),
      ),
    );
  }

  DropdownButton<String> combo() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Container inputProveedor() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.green)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              icon: Icon(Icons.people),
              hintText: "PROVEEDOR",
              border: InputBorder.none),
        ));
  }

  Container inputCantidad() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.green)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [cantidadMask],
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              icon: Icon(Icons.numbers),
              hintText: '123456',
              border: InputBorder.none),
        ));
  }

  Container inputFecha() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.green)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [fechaMask],
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              icon: Icon(Icons.date_range),
              hintText: '00/00/0000',
              border: InputBorder.none),
        ));
  }
}
