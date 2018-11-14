import 'package:flutter/foundation.dart';
import 'package:panelmex_app/models/user.dart';

class AppState {
  final User currentUser;

  AppState({
    @required this.currentUser,
  });

  AppState.initialState() : currentUser = null;
}
