import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/widgets/dialog_loading.dart';
import 'package:panelmex_app/screens/admin/home.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'LoginScreen';
  static String routerName = '/login';

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = new AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final emailTextController = TextEditingController();
  static final passwordTextController = TextEditingController();

  final TextField email = TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(labelText: 'Email'),
    controller: emailTextController,
  );

  final TextField password = TextField(
    obscureText: true,
    decoration: InputDecoration(labelText: 'Password'),
    controller: passwordTextController,
  );

  @override
  Widget build(BuildContext context) {
    FirebaseUser _currentUser;

    //Handlers
    Future _handlerLoginScreen() async {
      if (emailTextController.text == 'user' &&
          passwordTextController.text == 'user') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(_currentUser)));
      } else if (emailTextController.text == 'admin@gmail.com' &&
          passwordTextController.text == 'admin') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreenAdmin(_currentUser)));
      } else {
        try {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogLoading();
            },
          );

          _currentUser = await _authService.signIn(
              emailTextController.text, passwordTextController.text);

          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(_currentUser)));
        } on PlatformException catch (e) {
          Navigator.pop(context);

          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }

    Future _handlerSignInGoogle() async {
      try {
        _currentUser = await _authService.signInWithGoogle();

        Navigator.pop(context);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(_currentUser)));
      } on PlatformException catch (e) {
        Navigator.pop(context);

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.message),
        ));
      }
    }

    void _handlerNewAccount() {
      Navigator.of(context).pushNamed('/register');
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/dream-car.png'),
      ),
    );
    final LoginButtonRadius = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
            highlightColor: Colors.lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.input),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 18, bottom: 18),
                  child: Text('Iniciar sesion'),
                )
              ],
            ),
            textColor: Colors.white,
            onPressed: _handlerLoginScreen,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))));

    final LoginScreenButtonGoogle = RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/google.png',
              width: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 18, bottom: 18),
              child: Text(
                "Ingresa con Google",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(68, 68, 76, .8),
                ),
              ),
            ),
          ],
        ),
      ),
      color: Colors.white,
      splashColor: Colors.blueGrey,
      onPressed: () {
        _handlerSignInGoogle();
      },
    );

    final newAccount = FlatButton(
      child: Text(
        'Crear una cuenta',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        _handlerNewAccount();
      },
    );

    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.lightBlue[700],
                Colors.lightBlue[600],
                Colors.lightBlue[300],
                Colors.lightBlue[200],
              ],
            ),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(
                  height: 48.0,
                ),
                email,
                SizedBox(
                  height: 8.0,
                ),
                password,
                SizedBox(
                  height: 24.0,
                ),
                LoginButtonRadius,
                LoginScreenButtonGoogle,
                newAccount,
              ],
            ),
          ),
        ));
  }
}
