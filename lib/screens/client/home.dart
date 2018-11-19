import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/screens/client/list_services.dart';
import 'package:panelmex_app/screens/client/list_notifications.dart';
import 'package:panelmex_app/screens/client/profile.dart';
import 'package:panelmex_app/services/auth.dart';

class HomeScreen extends StatefulWidget {
  static String routerName = '/home';

  final FirebaseUser _currentUser;

  HomeScreen(this._currentUser);

  @override
  _HomeScreenState createState() => new _HomeScreenState(this._currentUser);
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final FirebaseUser _currentUser;
  AuthService _auth = new AuthService();

  _HomeScreenState(this._currentUser);

  Widget _renderScreen() {
    switch (_currentIndex) {
      case 0:
        return ListServices(_currentUser);
        break;
      case 1:
        return ListNotifications();
        break;
      case 2:
        return Profile();
        break;
      default:
        return null;
        break;
    }
  }

  static List<BottomNavigationBarItem> _itemsNavigationBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.airport_shuttle),
      title: Text('Servicios'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      title: Text('Notificaciones'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Perfil'),
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _handlerNewService() {
      Navigator.of(context).pushNamed('/new-service');
    }

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

    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Panelmex',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handlerNewService();
        },
        tooltip: 'Solicitar servicio',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _renderScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _itemsNavigationBar,
        onTap: onTabTapped,
      ),
    );
  }
}
