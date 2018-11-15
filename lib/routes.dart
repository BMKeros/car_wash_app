import 'package:flutter/material.dart';

//screens
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/screens/register.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/screens/client/new_service.dart';
import 'package:panelmex_app/screens/client/profile.dart';

final routes = {
  Login.routerName: (BuildContext context) => new Login(),
  Register.routerName: (BuildContext context) => new Register(),
  HomeClient.routerName: (BuildContext context) => new HomeClient(),
  NewService.routerName: (BuildContext context) => new NewService(),
  Profile.routerName: (BuildContext context) => new Profile(),
};
