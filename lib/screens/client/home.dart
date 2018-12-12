import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:panelmex_app/screens/login.dart';
import 'package:panelmex_app/screens/client/list_services.dart';
import 'package:panelmex_app/screens/client/list_notifications.dart';
import 'package:panelmex_app/screens/client/profile.dart';
import 'package:panelmex_app/services/auth.dart';
import 'package:panelmex_app/screens/client/new_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _HomeScreenState(this._currentUser);

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) async {
      await FirebaseDatabase.instance
          .reference()
          .child('/users/${_currentUser.uid}/deviceToken')
          .set(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  Widget _renderScreen() {
    switch (_currentIndex) {
      case 0:
        return ListServices(_currentUser);
        break;
      case 1:
        return ListNotifications();
        break;
      default:
        return null;
        break;
    }
  }

  static List<BottomNavigationBarItem> _itemsNavigationBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.local_car_wash),
      title: Text('Servicios'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      title: Text('Notificaciones'),
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewService(_currentUser)));
    }

    // Lista de botones para mostrar al cambiar de bottomNavigationBar
    List<FloatingActionButton> floatingActionButton = [
      FloatingActionButton(
        onPressed: _handlerNewService,
        tooltip: 'Nuevo servicio',
        child: Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: () {},
        tooltip: 'Ver notificaciones',
        child: Icon(Icons.notifications),
      ),
    ];

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
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(_currentUser)));
            },
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton[_currentIndex],
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
        child: _renderScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _itemsNavigationBar,
        onTap: onTabTapped,
      ),
    );
  }
}

