import 'package:flutter/material.dart';

var myDefaultBackground = Colors.grey[300];

var myAppBar = AppBar(
  backgroundColor: Colors.grey[900],
);

var myDrawer = Drawer(
  child: Column(
    children: const [
      DrawerHeader(
        child: Icon(Icons.favorite),
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('Buscar'),
      ),
      ListTile(
        leading: Icon(Icons.list),
        title: Text('Historial'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('A J U S T E S'),
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('S A L I R'),
      ),
    ],
  ),
);
