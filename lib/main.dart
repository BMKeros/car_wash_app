import 'package:flutter/material.dart';
import 'package:panelmex_app/routes.dart';
import 'package:panelmex_app/screens/login.dart';
import 'package:map_view/map_view.dart';
import 'package:panelmex_app/config/config.dart';

void main() {
  MapView.setApiKey(APIKEY);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      routes: routes,
    );
  }
}
