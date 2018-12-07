import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:panelmex_app/screens/client/service_detail.dart';
import 'package:panelmex_app/models/service.dart';

class ListServices extends StatefulWidget {
  FirebaseUser _currentUser;

  ListServices(this._currentUser);

  @override
  ListServicesState createState() => new ListServicesState(_currentUser);
}

class ListServicesState extends State<ListServices> {
  FirebaseUser _currentUser;
  List<Service> _items;

  StreamSubscription<Event> _onServiceAddedSubscription;
  StreamSubscription<Event> _onServiceChangedSubscription;

  DatabaseReference _serviceReference =
      FirebaseDatabase.instance.reference().child('services');

  ListServicesState(this._currentUser);

  @override
  void initState() {
    super.initState();
    _items = new List();

    _onServiceAddedSubscription = _serviceReference
        .orderByChild('uid')
        .equalTo(_currentUser.uid)
        .onChildAdded
        .listen(_onServiceAdded);

    _onServiceChangedSubscription = _serviceReference
        .orderByChild('uid')
        .equalTo(_currentUser.uid)
        .onChildChanged
        .listen(_onServiceUpdated);
  }

  @override
  void dispose() {
    super.dispose();
    _onServiceAddedSubscription.cancel();
    _onServiceChangedSubscription.cancel();
  }

  void _onServiceAdded(Event event) {
    setState(() {
      _items.add(new Service.fromSnapshot(event.snapshot));
    });
  }

  void _onServiceUpdated(Event event) {
    var oldServiceValue = _items.singleWhere((service) => service.key == event.snapshot.key);
    setState(() {
      _items[_items.indexOf(oldServiceValue)] = new Service.fromSnapshot(event.snapshot);
    });
  }

  Icon _getIconStatus(String status) {
    IconData icon;
    MaterialColor color;

    switch (status) {
      case 'pending':
        icon = Icons.timer;
        color = Colors.orange;
        break;
      case 'accepted':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'cancelled':
        icon = Icons.close;
        color = Colors.red;
        break;
      default:
        icon = Icons.timer;
        color = Colors.orange;
        break;
    }

    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (BuildContext ctx, int index) => Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 4, top: 3,),
                    child: Icon(Icons.timer, size: 15,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(_items[index].parseTime),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7, top: 3, right: 4,),
                    child: Icon(Icons.date_range, size: 15,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(_items[index].date),
                  ),
                  Divider(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ServiceDetail(_currentUser, _items[index]),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      child: Image.asset('assets/car-wash.png'),
                    ),
                    title: Text(
                      _items[index].type,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                    trailing: _getIconStatus(_items[index].status),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7,
                            top: 3,
                          ),
                          child: Icon(
                            Icons.timer,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(_items[index].time),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 3,
                            right: 7,
                          ),
                          child: Icon(
                            Icons.date_range,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(_items[index].date),
                        )
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}

/*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ServiceDetail(_currentUser, _items[index]),
                ),
              );
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
                                    _items[index].type,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0),
                                  ),
                                  _getIconStatus(_items[index].status),
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
                                      child: Text(_items[index].time),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 23.0),
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
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(_items[index].date),
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
      ),
    );
  }
}*/
