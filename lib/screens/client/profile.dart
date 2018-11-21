import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  static String routerName = '/profile';

  final FirebaseUser _currentUser;

  Profile(this._currentUser);

  @override
  _ProfileState createState() => new _ProfileState(this._currentUser);
}
class _ProfileState extends State<Profile> {
  final FirebaseUser _currentUser;

  _ProfileState(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                child: Image.asset('assets/user.png', height: 150,),
                backgroundColor: Colors.grey[100],
                radius: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                leading: Icon(
                  Icons.people
                ),
                title: Text("Vanesa Castro"),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.email
              ),
              title: Text("prueba@gmail.com"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.phone
              ),
              title: Text("+58-4165625564"),
            ),
          ],
        ),
      )
    );
  }
}