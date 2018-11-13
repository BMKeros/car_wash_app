import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static String tag = 'login';
  @override
  _LoginState createState() => new _LoginState();
 }
class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    
    //Handlers
    void _handlerLogin () {
      Navigator.of(context).pushNamed('/home');
    }
    void _handlerSignInGoogle() {
      
    }
    void _handlerNewAccount () {
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

    /*final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Correo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );*/
    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo'
      ),
    );


    /*final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contrasena',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );*/
    final password = TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contrasena'
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () { _handlerLogin(); },
          color: Colors.lightBlueAccent,
          child: Text('Iniciar de secion', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
    final loginButtonGoogle = RaisedButton(
      child:  Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/google.png', width: 25.0,),
            Padding(
              child: Text("Ingresa con Google", style: TextStyle(fontFamily: 'Roboto',color: Color.fromRGBO(68, 68, 76, .8),
              ),
            ),
              padding: new EdgeInsets.only(left: 15.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
      splashColor: Colors.blueGrey,
      onPressed: () { _handlerSignInGoogle(); },
    );

    final newAccount = FlatButton(
      child: Text('Crear una cuenta', style: TextStyle(color: Colors.black54),),
      onPressed: (){ _handlerNewAccount(); },
    );
   
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0,),
            email,
            SizedBox(height: 8.0,),
            password,
            SizedBox(height: 24.0,),
            loginButton,
            loginButtonGoogle,
            newAccount,
          ],
        ),
      ),
      
    );
  }
}