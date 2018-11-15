import 'package:flutter/material.dart';

class ListServices extends StatefulWidget {
  @override
  ListServicesState createState() => new ListServicesState();
}

class ListServicesState extends State<ListServices> {
  var listViewItems = [
    ['Lavado por fuera', 'assets/car-wash.png', '20/5/2018', '8:30', 'Pendiente'],
    ['Lavado completo', 'assets/car-wash.png', '13/4/2018', '8:30', 'Rechazado'],
    ['Lavado por fuera', 'assets/car-wash.png', '17/52/2018','9:00', 'Finalizado'],
    ['Lavado completo', 'assets/car-wash.png', '20/5/2018', '16:00', 'Pendiente'],
    ['Limpieza interior', 'assets/car-wash.png', '13/4/2018', '9:30','Rechazado'],
    ['Lavado por fuera', 'assets/car-wash.png', '17/52/2018', '10:00', 'Finalizado'],
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemCount: listViewItems.length,
        itemBuilder: (BuildContext ctx, int index) {
          return GestureDetector(
            onTap: () {
              print(listViewItems[index]);
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.asset('assets/car-wash.png'),
                        
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    listViewItems[index][0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0),
                                  ),
                                  Icon(
                                      Icons.check_circle, //Aceptado
                                      //Icons.close - Cancelado
                                      //Icons.timer - pendiente
                                      color: Colors.green,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.timer),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(listViewItems[index][3]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(Icons.date_range),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(listViewItems[index][2]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      )
    );
  }
}
/*ListView.builder(
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
