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
  List<String> imagePromotions = [
    'xbox.jpg',
    'cine.jpg',
    'audifonos.jpg',
    'altavoz.jpg',
    'saldo.jpg',
    'netflix.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(9),
            child: Text(
              'Promociones\nLas siguientes imágenes son ilustrativas',
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width / 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePromotions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage('assets/promotions/' + imagePromotions[index]),
                        fit: BoxFit.fill
                      )
                    ),
                  )
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
          Expanded(
            child: FirebaseAnimatedList(
              query: _notificationsRef.child('/${_currentUser.uid}'),
              sort: (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Center(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.05,
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(snapshot.value['title']),
                          isThreeLine: true,
                          subtitle: Text(
                            snapshot.value['body'],
                            style: TextStyle(color: Colors.black),
                          ),
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
