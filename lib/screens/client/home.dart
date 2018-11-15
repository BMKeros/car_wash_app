import 'package:flutter/material.dart';
import 'package:panelmex_app/screens/client/list_services.dart';
import 'package:panelmex_app/screens/client/list_notifications.dart';
import 'package:panelmex_app/screens/client/profile.dart';

class HomeClient extends StatefulWidget {
  static String routerName = '/home';

  @override
  _HomeClientState createState() => new _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ListServices(),
    ListNotifications(),
    Profile(),
  ];

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
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Ajustes',
                  child: Text('Ajustes1'),
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _itemsNavigationBar,
        onTap: onTabTapped,
      ),
    );
  }
}
