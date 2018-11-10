import 'package:flutter/material.dart';
import 'package:panelmex_app/routes.dart';
import 'package:panelmex_app/screens/login.dart';

void main() {
runApp(new MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
    ),
    routes: routes,
    ));
}