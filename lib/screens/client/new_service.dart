import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

class NewService extends StatefulWidget {
  static String routerName = '/new-service';

  @override
  _NewServiceState createState() => new _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  MapView mapView = new MapView();
  final _formKey = GlobalKey<FormState>();

  String _date;
  String _time;

  int selectedServiceType = null;
  int selectedPaymentMethod = null;
  static double _latitud = 23.87;
  static double _longitud = -102.66;

  final List<DropdownMenuItem> _itemsServiceType = [
    DropdownMenuItem(
      child: Text('Por fuera'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Completo'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('Pulido'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('Encerado'),
      value: 4,
    )
  ];

  final List<DropdownMenuItem> _itemsPaymentMethod = [
    DropdownMenuItem(
      child: Text('Efectivo'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Tarjeta'),
      value: 2,
    )
  ];

  List<Marker> markers = <Marker>[];

  _handlerShowMap() {
    mapView.show(
      MapOptions(
        mapViewType: MapViewType.normal,
        showUserLocation: true,
        showMyLocationButton: true,
        title: 'Direccion',
        hideToolbar: false,
        showCompassButton: true,
      ),
      toolbarActions: [
        new ToolbarAction("Cerrar", 1),
        new ToolbarAction("Confirmar", 2)
      ],
    );

    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      } else if (id == 2) {
        if (mapView.markers.isNotEmpty) {
          setState(() {
            _latitud = mapView.markers[0].latitude;
            _longitud = mapView.markers[0].longitude;
          });
          mapView.dismiss();
        }
      }
    });

    mapView.onMapTapped.listen((tapped) {
      print('Latitud seleccionada ${tapped.latitude}');
      print('Longitud selecionada ${tapped.longitude}');

      mapView.addMarker(new Marker(
        '1',
        'Direccion Servicio',
        _latitud,
        _longitud,
        color: Colors.lightBlue,
        draggable: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Nuevo servicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // If the form is valid, we want to show a Snackbar
            print('error en el formulario');
          }
        },
        tooltip: 'Guardar',
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DateTimePickerFormField(
                    decoration: InputDecoration(labelText: 'Fecha'),
                    format: DateFormat.yMd(),
                    onChanged: (DateTime date) {
                      _date = date.toString();
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TimePickerFormField(
                    decoration: InputDecoration(labelText: 'Hora'),
                    format: DateFormat.Hms(),
                    onChanged: (TimeOfDay time) {
                      _time = time.toString();
                    },
                  ),
                  ListTile(
                    title: Text('Tipo de servicio'),
                    trailing: DropdownButton(
                      value: selectedServiceType,
                      items: _itemsServiceType,
                      onChanged: (value) {
                        selectedServiceType = value;
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Metodo de pago'),
                    trailing: DropdownButton(
                      value: selectedPaymentMethod,
                      items: _itemsPaymentMethod,
                      onChanged: (value) {
                        selectedPaymentMethod = value;
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.zoom_out_map),
                          Padding(
                            child: Text(
                              "Direccion para el servicio",
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
                    splashColor: Colors.lightBlue,
                    onPressed: _handlerShowMap,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.lightBlueAccent.shade100,
                        elevation: 5.0,
                        child: MaterialButton(
                          minWidth: 200.0,
                          height: 42.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, we want to show a Snackbar
                              FirebaseDatabase.instance
                                  .reference()
                                  .child('services')
                                  .push()
                                  .set({
                                'type': 'Lavado completo',
                                'date': '19-09-2018',
                                'time': '19:00:00',
                              });
                            }
                          },
                          color: Colors.lightBlueAccent,
                          child: Text(
                            'Solicitar Servicio',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
