import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:panelmex_app/screens/client/service_detail.dart';
import 'package:panelmex_app/models/service.dart';
import 'package:panelmex_app/ui/card_service.dart';

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
  StreamSubscription<Event> _onServiceRemoveSubscription;

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

    _onServiceRemoveSubscription = _serviceReference
        .orderByChild('uid')
        .equalTo(_currentUser.uid)
        .onChildRemoved
        .listen(_onServiceRemove);
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
    var oldServiceValue =
        _items.singleWhere((service) => service.key == event.snapshot.key);
    setState(() {
      _items[_items.indexOf(oldServiceValue)] =
          new Service.fromSnapshot(event.snapshot);
    });
  }

  void _onServiceRemove(Event event) {
    setState(() {
      _items.removeWhere((service) => service.key == event.snapshot.key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              CardService(service: _items[index]),
              index == _items.length - 1
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(
                      height: 0,
                    )
            ],
          );
        },
      ),
    );
  }
}
