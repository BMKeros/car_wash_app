import 'package:flutter/material.dart';

class ListNotifications extends StatefulWidget {
  @override
  ListNotificationsState createState() => new ListNotificationsState();
}

class ListNotificationsState extends State<ListNotifications> {
  var listViewItems = [
    ['Notificacion 1', '20/5/2018', 'Pendiente'],
    ['Notificacion 1', '13/4/2018', 'Rechazado'],
    ['Notificacion 1', '17/52/2018', 'Finalizado'],
    ['Notificacion 1', '20/5/2018', 'Pendiente'],
    ['Notificacion 1', '13/4/2018', 'Rechazado'],
    ['Notificacion 1', '17/52/2018', 'Finalizado'],
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: /*ListView.builder(
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
      ),*/
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(9),
            child: Text(
              'Promociones',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17
              ),
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: 200,
                    height: 150,
                    color: Colors.blueGrey,
                    child: Text('Contenedor $index'),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
    
  }
}
