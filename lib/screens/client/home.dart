import 'package:flutter/material.dart';

class HomeClient extends StatefulWidget {
  @override
  _HomeClientState createState() => new _HomeClientState();
 }
class _HomeClientState extends State<HomeClient> {

  var listViewItems = {
    0: ['Lavado completo','20/5/2018','Pendiente'],
    1: ['Limpieza interior','13/4/2018','Rechazado'],
    2: ['Brillo','17/52/2018','Finalizado'],
    3: ['Lavado completo','20/5/2018','Pendiente'],
    4: ['Limpieza interior','13/4/2018','Rechazado'],
    5: ['Brillo','17/52/2018','Finalizado'],

  };

  @override
  Widget build(BuildContext context) {
    void _handlerNewService() {
      Navigator.of(context).pushNamed('/new-service');
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white,),
        title: Text('Panelmex', style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { _handlerNewService(); },
        tooltip: 'Solicitar servicio',
        child: Icon(Icons.add, color: Colors.white,),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Material(
                child: Image.asset('assets/dream-car.jpg'),
              ),
            ),

            ListTile(
              leading: Icon(Icons.person, color: Colors.lightBlue),
              title: Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.airport_shuttle, color: Colors.lightBlue),
              title: Text('Servicios'),
              onTap: () {}
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.lightBlue),
              title: Text('Notificaciones'),
              onTap: () {},
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.lightBlue),
              title: Text('Salir'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listViewItems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            title: Text(listViewItems[index][0]),
            subtitle: Text(listViewItems[index][1]),
            leading: Icon(
              Icons.airport_shuttle,
              color: Colors.blue[500],
            ),
            trailing: Icon(
              Icons.check
            ),
          );
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getFooterItems(),
      ),
      
    );
  }
}

List<BottomNavigationBarItem> _getFooterItems() {
  return [
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
}