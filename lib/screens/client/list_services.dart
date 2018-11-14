import 'package:flutter/material.dart';

class ListServices extends StatefulWidget {
  @override
  ListServicesState createState() => new ListServicesState();
}

class ListServicesState extends State<ListServices> {
  var listViewItems = [
    ['Lavado completo', '20/5/2018', 'Pendiente'],
    ['Limpieza interior', '13/4/2018', 'Rechazado'],
    ['Brillo', '17/52/2018', 'Finalizado'],
    ['Lavado completo', '20/5/2018', 'Pendiente'],
    ['Limpieza interior', '13/4/2018', 'Rechazado'],
    ['Brillo', '17/52/2018', 'Finalizado'],
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemCount: listViewItems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            title: Text(listViewItems[index][0]),
            subtitle: Text(listViewItems[index][1]),
            leading: Icon(
              Icons.airport_shuttle,
              color: Colors.blue[500],
            ),
            trailing: Icon(Icons.check),
          );
        },
      ),
    );
  }
}
