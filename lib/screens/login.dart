import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/screens/client/home.dart';

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
    decoration: InputDecoration(labelText: 'Correo'),
    controller: emailTextController,
  );

  final TextField password = TextField(
    obscureText: true,
    decoration: InputDecoration(labelText: 'Contrasena'),
    controller: passwordTextController,
  );

  @override
  Widget build(BuildContext context) {
    FirebaseUser _currentUser;

    //Handlers
    Future _handlerLoginScreen() async {
      try {
        _currentUser = await _authService.signIn(
            emailTextController.text, passwordTextController.text);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(_currentUser)));
      } on PlatformException catch (e) {
        final snackBar = SnackBar(
          content: Text(e.message),
        );

        // Find the Scaffold in the Widget tree and use it to show a SnackBar!
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }

    Future _handlerSignInGoogle() async {
      try {
        _currentUser = await _authService.signInWithGoogle();
      } on PlatformException catch (e) {}
    }

    void _handlerNewAccount() {
      Navigator.of(context).pushNamed('/register');
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/dream-car.jpg'),
      ),
    );

    final LoginScreenButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _handlerLoginScreen();
          },
          color: Colors.lightBlueAccent,
          child: Text(
            'Iniciar de secion',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final LoginScreenButtonGoogle = RaisedButton(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/google.png',
              width: 25.0,
            ),
            Padding(
              child: Text(
                "Ingresa con Google",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(68, 68, 76, .8),
                ),
              ),
              padding: new EdgeInsets.only(left: 15.0),
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
      body: Center(
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
            LoginScreenButton,
            LoginScreenButtonGoogle,
            newAccount,
          ],
        ),
      ),
    );
  }
}

