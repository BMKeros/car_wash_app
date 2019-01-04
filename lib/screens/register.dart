import 'package:flutter/material.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:panelmex_app/widgets/dialog_loading.dart';

class Register extends StatefulWidget {
  static String routerName = '/register';

  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final _authService = new AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final emailTextController = new TextEditingController();
  static final passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseUser _currentUser;

    Future _handleSignUp() async {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogLoading(
              message: 'Registrando Usuario',
            );
          },
        );

        await _authService.signUp(
            emailTextController.text, passwordTextController.text);
        _currentUser = await _authService.signIn(
            emailTextController.text, passwordTextController.text);

        Navigator.pop(context);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(_currentUser)));
      } on PlatformException catch (e) {

        Navigator.pop(context);

        final snackBar = SnackBar(
          content: Text(e.message),
        );

        // Find the Scaffold in the Widget tree and use it to show a SnackBar!
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/dream-car.png'),
      ),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Correo electronico'),
      controller: emailTextController,
    );

    final passwordOne = TextField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Contraseña'),
      controller: passwordTextController,
    );
    final passwordTwo = TextField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Repita la contraseña'),
    );

    final newAccountButtonRadius = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        highlightColor: Colors.lightBlueAccent,
        child: new Text('Nueva cuenta', style: TextStyle(color: Colors.white)),
        textColor: Colors.white,
        onPressed: _handleSignUp,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Ya tengo una cuenta',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pop();
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
            //SizedBox(height: 25.0,),
            //name,
            SizedBox(
              height: 48.0,
            ),
            email,
            SizedBox(
              height: 8.0,
            ),
            passwordOne,
            SizedBox(
              height: 8.0,
            ),
            passwordTwo,
            SizedBox(
              height: 20.0,
            ),
            newAccountButtonRadius,
            forgotLabel,
          ],
        ),
      ),
    );
  }
}
