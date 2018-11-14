import 'package:flutter/material.dart';

//screens
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/screens/register.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/screens/client/new_service.dart';
import 'package:panelmex_app/screens/client/profile.dart';

final routes = {
  '/login': (BuildContext context) => new Login(),
  '/register': (BuildContext context) => new Register(),
  '/home': (BuildContext context) => new HomeClient(),
  '/new-service' : (BuildContext context) => new NewService(),
  '/profile': (BuildContext context) => new Profile(),
};