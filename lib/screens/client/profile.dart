import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/services/auth.dart';

class Profile extends StatefulWidget {
  static String routerName = '/profile';

  final FirebaseUser _currentUser;

  Profile(this._currentUser);

  @override
  _ProfileState createState() => new _ProfileState(this._currentUser);
}
class _ProfileState extends State<Profile> {

  final FirebaseUser _currentUser;
  AuthService _auth = new AuthService();
  _ProfileState(this._currentUser);
  
   void _onSelectedPopupMenu(String menuKey) async {
      switch (menuKey) {
        case 'menu_signout':
          await _auth.signOutFirebase();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
          break;
      }
    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: new IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _onSelectedPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'menu_signout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Salir'),
                  ),
                )
              ];
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                Hero(
                  tag: 'assets/avatars/avatar-4.jpg',
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/avatars/avatar-4.jpg')
                      )
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text(
                  'Vanesa Castro',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Santa Barbara',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.grey
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Pendientes',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '22',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Aceptados',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Rechazados',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.blueGrey
                        ),
                        title: Text(
                          "prueba@gmail.com",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.blueGrey
                        ),
                        title: Text(
                          "+58-4165625564",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                /*buildImages(),
                buildInfoDetail(),
                buildImages(),
                buildInfoDetail(),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}