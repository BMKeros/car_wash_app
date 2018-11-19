import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/screens/client/service_detail.dart';

class ListServices extends StatefulWidget {
  FirebaseUser _currentUser;

  ListServices(this._currentUser);

  @override
  ListServicesState createState() => new ListServicesState(_currentUser);
}

class ListServicesState extends State<ListServices> {
  FirebaseUser _currentUser;

  ListServicesState(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('services')
          .where("uid", isEqualTo: _currentUser.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
              snapshot.data.documents.map((DocumentSnapshot document) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceDeatil()));
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          document['type'],
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.timer),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child:
                                            Text(document['time']),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 23.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(Icons.date_range),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                          document['date']),
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
              }).toList(),
            );
        }
      },
    );
  }
}
