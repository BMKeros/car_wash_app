import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/common/constans.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/models/profile.dart';
import 'package:panelmex_app/screens/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  static String routerName = '/profile';

  final FirebaseUser _currentUser;

  ProfileScreen(this._currentUser);

  @override
  _ProfileScreenState createState() =>
      new _ProfileScreenState(this._currentUser);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseUser _currentUser;
  AuthService _auth = new AuthService();

  _ProfileScreenState(this._currentUser);

  DatabaseReference _servicesRef =
  FirebaseDatabase.instance.reference().child('services');
  DatabaseReference _profileRef =
  FirebaseDatabase.instance.reference().child('users');

  StorageReference _imagesRef = FirebaseStorage.instance.ref().child('images');

  int _totalPending = 0;
  int _totalAccepted = 0;
  int _totalRefused = 0;
  String _profileImageUrl;
  bool _changedProfileScreenImage = false;
  Profile _profile = Profile('', '', '', '', '', '');

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

    _profileRef
        .child('/${_currentUser.uid}/profile')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        _profile = Profile.fromSnapshot(snapshot);
      });
    });
  }

  void _onSelectedPopupMenu(String menuKey, BuildContext context) async {
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

  void _uploadProfileImage(File file) async {
    final StorageUploadTask uploadTask = _imagesRef
        .child(_currentUser.uid)
        .child('profile_image${extension(file.path)}')
        .putFile(file);

    final StorageTaskSnapshot snapshot = await uploadTask.onComplete;

    final String url = await snapshot.ref.getDownloadURL();

    _profileRef
        .child('/${_currentUser.uid}/profile')
        .update({'image_url': url});

    setState(() {
      _changedProfileScreenImage = true;
      _profileImageUrl = url;
    });
  }

  ImageProvider renderProfileImage() {
    if (_profile.hasImage) {
      return NetworkImage(_profile.imageUrl);
    }
    return AssetImage('assets/avatars/empty-profile.png');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(_currentUser),
              ),
            );
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
            onSelected: (String menu) async {
              _onSelectedPopupMenu(menu, context);
            },
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
                            image: _changedProfileScreenImage
                                ? NetworkImage(_profileImageUrl)
                                : renderProfileImage(),
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
                        onPressed: () async {
                          _uploadProfileImage(
                            await ImagePicker.pickImage(
                              source: ImageSource.gallery,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _profile.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(
                                    'Editar nombre',
                                    '',
                                    [_profile.firstName, _profile.lastName],
                                    _currentUser),
                          ),
                        );
                      },
                    ),
                  ],
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Pendientes',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Aceptadas',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rechazadas',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
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
                          '${_profile.phoneNumber}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueGrey),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(
                                      'Editar numero',
                                      'Numero',
                                      [_profile.phoneNumber],
                                      _currentUser,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.map,
                          color: Colors.blueGrey,
                        ),
                        title: Text(
                          '${_profile.address}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueGrey),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(
                                      'Editar dirrecion',
                                      'Direccion',
                                      [_profile.address],
                                      _currentUser,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
