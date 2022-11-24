import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meso_programovil_final/views/responsive/constants.dart';
import 'package:meso_programovil_final/views/util/my_box.dart';
import 'package:meso_programovil_final/views/util/my_tile.dart';

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

var fechaMask =
    MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

var cantidadMask =
    MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});

String dropdownValue = list.first;

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
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
            const Text('PERSONA ACREEDORA:'),
            inputProveedor(),
            const SizedBox(
              height: 20,
            ),
            const Text('TOTAL SALIDA: '),
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
            combo(),
            const Text('ESCRIBA UN AREA:'),
            inputArea(),
            const SizedBox(
              height: 10,
            ),
            const Text('ESCRIBA EL DESTINO:'),
            inputDestino(),
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

  SizedBox combo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 26,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.green)),
          child: DropdownButton<String>(
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
          )),
    );
  }
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
            hintText: "ACREEDOR",
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

Container inputArea() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.green)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
            icon: Icon(Icons.developer_board_outlined),
            hintText: "AREA",
            border: InputBorder.none),
      ));
}

Container inputDestino() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.green)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
            icon: Icon(Icons.place_outlined),
            hintText: "DESTINO",
            border: InputBorder.none),
      ));
}
