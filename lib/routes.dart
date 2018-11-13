import 'package:flutter/material.dart';

//screens
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/screens/register.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/screens/client/new_service.dart';

final routes = {
  '/login': (BuildContext context) => Login(),
  '/register': (BuildContext context) => Register(),
  '/home': (BuildContext context) => HomeClient(),
  '/new-service': (BuildContext context) => NewService(),
};