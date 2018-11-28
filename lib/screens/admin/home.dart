import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/screens/admin/swipe_animation/index.dart';

class HomeScreenAdmin extends StatefulWidget {
  final FirebaseUser _currentUser;

  HomeScreenAdmin(this._currentUser);
  @override
  _HomeScreenAdminState createState() => new _HomeScreenAdminState(this._currentUser);
 }
class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  final FirebaseUser _currentUser;
  AuthService _auth = new AuthService();
  _HomeScreenAdminState(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return HomeCard();
  }
}