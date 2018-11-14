import 'package:panelmex_app/redux/state.dart';
import 'package:panelmex_app/redux/actions.dart';
import 'package:panelmex_app/models/user.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    currentUser: userReducer(state.currentUser, action),
  );
}

User userReducer(User state, action) {
  if (action is SaveUserAction) {
    return User(state.uid, state.email);
  }
  return state;
}
