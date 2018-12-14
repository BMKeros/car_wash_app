import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class ListNotifications extends StatefulWidget {
  final FirebaseUser _currentUser;

  ListNotifications(this._currentUser);

  @override
  ListNotificationsState createState() =>
      new ListNotificationsState(this._currentUser);
}

class ListNotificationsState extends State<ListNotifications> {
  final FirebaseUser _currentUser;

  ListNotificationsState(this._currentUser);

  DatabaseReference _notificationsRef =
      FirebaseDatabase.instance.reference().child('notifications');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(9),
            child: Text(
              'Promociones',
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
          ),
          Container(
            height: 125,
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
          ),
          Padding(
            padding: EdgeInsets.all(9),
            child: Text(
              'Notificaciones',
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
          ),
          /*Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext ctx, int index) => Column(
                    children: <Widget>[
                      Container(
                        width: 380,
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text('Titulo'),
                            subtitle: Text(
                              'Su servicio ha sido aceptado correctamente.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
            ),
          )


            */
          Expanded(
            child: FirebaseAnimatedList(
              query: _notificationsRef.child('/${_currentUser.uid}'),
              sort: (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Container(
                    width: 380,
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(snapshot.value['title']),
                        subtitle: Text(
                          snapshot.value['body'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
