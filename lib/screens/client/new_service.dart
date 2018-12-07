import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

import 'package:panelmex_app/widgets/dialog_loading.dart';
import 'package:panelmex_app/screens/client/home.dart';
import 'package:panelmex_app/config/config.dart';

class NewService extends StatefulWidget {
  static String routerName = '/new-service';

  final FirebaseUser _currentUser;

  NewService(this._currentUser);

  @override
  _NewServiceState createState() => new _NewServiceState(this._currentUser);
}

class _NewServiceState extends State<NewService> {
  final FirebaseUser _currentUser;

  _NewServiceState(this._currentUser);
  
  MapView mapView = new MapView();
  var staticMapProvider = new StaticMapProvider(APIKEY);
  Uri _staticMapUri;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _couponController = TextEditingController();

  int selectedServiceType = null;
  int selectedPaymentMethod = null;
  int selectedWashingType = null;

  static double _latitud = 23.87;
  static double _longitud = -102.66;
  bool coupon = false;

  final List _dataServiceType = ['Por fuera', 'Completo', 'Pulido', 'Encerado'];
  final List _dataPaymentMethod = ['Tarjeta', 'Efectivo'];
  final List _dataWashingType = ['car', 'van'];

  final List<DropdownMenuItem> _itemsServiceType = [
    // select service type
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

  final List<DropdownMenuItem> _itemsWashingType = [
    DropdownMenuItem(
      child: Text('Carro'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Camioneta'),
      value: 2,
    )
  ];

  List<Marker> markers = <Marker>[];

  _handlerShowMap() {
    mapView.show(
      MapOptions(
        initialCameraPosition: CameraPosition(Location(_latitud, _longitud), 5),
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

    mapView.onToolbarAction.listen((id) async {
      if (id == 1) {
        mapView.dismiss();
      } else if (id == 2) {
        var currentUriMap =  await staticMapProvider.getImageUriFromMap(mapView, width: 900, height: 400);
        if (mapView.markers.isNotEmpty) {
          setState(() {
            _latitud = mapView.markers[0].latitude;
            _longitud = mapView.markers[0].longitude;
            _staticMapUri = currentUriMap;

          });
          mapView.dismiss();
        }
      }
    });

    mapView.onMapTapped.listen((tapped) {
      print('Latitud seleccionada ${tapped.latitude}');
      print('Longitud selecionada ${tapped.longitude}');

      setState(() {
        markers = []..add(new Marker(
          '1',
          'Direccion',
          tapped.latitude,
          tapped.longitude,
          color: Colors.lightBlue,
          draggable: true,
        ));
      });
      mapView.setMarkers(markers);
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
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // If the form is valid, we want to show a Snackbar
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogLoading(message: "Solicitando Servicio");
              },
            );

            await FirebaseDatabase.instance
                .reference()
                .child('services')
                .push()
                .set({
              'uid': _currentUser.uid,
              'type': _dataServiceType[selectedServiceType - 1],
              'washing_type': _dataWashingType[selectedWashingType - 1],
              'payment_method': _dataPaymentMethod[selectedPaymentMethod - 1],
              'date': _dateController.text,
              'time': _timeController.text,
              'status': 'pending',
              'created_date': DateTime.now().toString(),
              'static_map_uri': _staticMapUri.toString(),
              'coupon': _couponController.text,
              'latitude': _latitud,
              'longitude': _longitud
            });

            Navigator.pop(context);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(this._currentUser)));
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
                    controller: _dateController,
                    dateOnly: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TimePickerFormField(
                    decoration: InputDecoration(labelText: 'Hora'),
                    format: DateFormat.Hms(),
                    controller: _timeController,
                  ),
                  ListTile(
                    title: Text('Tipo de servicio'),
                    trailing: DropdownButton(
                      value: selectedServiceType,
                      items: _itemsServiceType,
                      onChanged: (value) {
                        setState(() {
                          selectedServiceType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Tipo de lavado'),
                    trailing: DropdownButton(
                      value: selectedWashingType,
                      items: _itemsWashingType,
                      onChanged: (value) {
                        setState(() {
                           selectedWashingType = value;              
                        });
                      },  
                    )

                  ),
                  ListTile(
                    title: Text('Metodo de pago'),
                    trailing: DropdownButton(
                      value: selectedPaymentMethod,
                      items: _itemsPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.my_location),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Posees un cupon.?'),
                      Switch(
                        value: coupon,
                        onChanged: (bool value) {
                          setState(() {
                            coupon = value;
                            _couponController.text = '';
                          });
                        },
                      )
                    ],
                  ),
                  coupon ? TextField(
                    decoration: InputDecoration(labelText: 'Ingrese tu cupon'),
                    controller: _couponController,
                  )
                  : Text('')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
