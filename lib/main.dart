import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:panelmex_app/routes.dart';
import 'package:panelmex_app/config/config.dart';
import 'package:panelmex_app/screens/splash.dart';
import 'package:panelmex_app/screens/login.dart';

void main() {
  MapView.setApiKey(APIKEY);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.blue
      ),
      routes: routes,
    );
  }
}
