import 'dart:io';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelmex_app/models/service.dart';
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/common/constans.dart';

class Profile extends StatefulWidget {
  static String routerName = '/profile';

  final FirebaseUser _currentUser;

  Profile(this._currentUser);

  @override
  _ProfileState createState() => new _ProfileState(this._currentUser);
}

class _ProfileState extends State<Profile> {
  final FirebaseUser _currentUser;
  AuthService _auth = new AuthService();

  _ProfileState(this._currentUser);

  DatabaseReference _servicesRef =
  FirebaseDatabase.instance.reference().child('services');

  int _totalPending = 0;
  int _totalAccepted = 0;
  int _totalRefused = 0;
  List<Service> _services;
  File _profileImageFile;

  @override
  void initState() {
    super.initState();

    _servicesRef
        .orderByChild('uid')
        .equalTo(_currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      var dataService = snapshot.value as Map;
      var tmpAccepted = 0;
      var tmpPending = 0;
      var tmpRefused = 0;

      dataService.forEach((key, value) {
        switch (value['status']) {
          case STATUS_ACCEPTED:
            tmpAccepted += 1;
            break;
          case STATUS_REFUSED:
            tmpRefused += 1;
            break;
          case STATUS_PENDING:
            tmpPending += 1;
            break;
        }
      });

      setState(() {
        _totalAccepted = tmpAccepted;
        _totalPending = tmpPending;
        _totalRefused = tmpRefused;
      });
    });
  }

  void _onSelectedPopupMenu(String menuKey) async {
    switch (menuKey) {
      case 'menu_signout':
        await _auth.signOutFirebase();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: new IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _onSelectedPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'menu_signout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Salir'),
                  ),
                )
              ];
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'xxx',
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(92.5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _profileImageFile == null
                                ? AssetImage('assets/avatars/empty-profile.png')
                                : FileImage(_profileImageFile),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      left: 120,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() async {
                            _profileImageFile = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Vanesa Castro',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Santa Barbara',
                  style:
                  TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _totalPending.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Pendientes',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _totalAccepted.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Aceptadas',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _totalRefused.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rechazadas',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.email, color: Colors.blueGrey),
                          title: Text(
                            _currentUser.email,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone, color: Colors.blueGrey),
                          title: Text(
                            "+58-4165625564",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    )),
                /*buildImages(),
                buildInfoDetail(),
                buildImages(),
                buildInfoDetail(),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
