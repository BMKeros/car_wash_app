import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class NewService extends StatefulWidget {
  @override
  _NewServiceState createState() => new _NewServiceState();
 }
class _NewServiceState extends State<NewService> {
  MapView mapView = new MapView();  
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<DropdownMenuItem<int>>  itemsServiceType = [];
  List<DropdownMenuItem<int>> itemsPaymentMethod = [];

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int selectedServiceType = null;
  int selectedPaymentMethod = null;
  static double _latitud = 23.87;
  static double _longitud = -102.66;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2050)
    );

    if (picked != null) {
      setState(() {
        _date = picked;
        dateController.text = picked.toString();
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time
    );
    
    if (picked != null) {
      setState(() {
        _time = picked;
        timeController.text = picked.toString();
      });
    }
  }

  void loadDataItems() {
    itemsServiceType = [];
    itemsPaymentMethod= [];

    itemsServiceType.add(DropdownMenuItem(
      child: Text('Por fuera'), 
      value: 1,)
    );
    itemsServiceType.add(DropdownMenuItem(
      child: Text('Completo'), 
      value: 2,)
    );

     itemsPaymentMethod.add(DropdownMenuItem(
      child: Text('Efectivo'), 
      value: 1,)
    );
    itemsPaymentMethod.add(DropdownMenuItem(
      child: Text('Tarjeta'), 
      value: 2,)
    );
  }
  List<Marker> markers = <Marker>[
    new Marker('1', 'Direccion', _latitud, _longitud, color: Colors.lightBlue, draggable: true)
  ];
  _handlerShowMap() {
    
    mapView.show(
      MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition: new CameraPosition(Location(23.87, -102.66), 5.0),
        showUserLocation: true,
        title: 'Direccion del servicio.',
        hideToolbar: false,
        showCompassButton: true,
      ),
      toolbarActions: [new ToolbarAction("Cerrar", 1), new ToolbarAction("Confirmar", 2)],
    );
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      } else if (id == 2) {
        if (mapView.markers.isNotEmpty){
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
      setState(() {
        markers = []..add(new Marker('1', 'Direccion Servicio', _latitud, _longitud, color: Colors.lightBlue, draggable: true,)); 
      });
      mapView.setMarkers(markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    loadDataItems();

    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white,),
        title: Text('Nuevo servicio', style: TextStyle(color: Colors.white),),
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
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Seleccione la fecha',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () { _selectDate(context); }
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Debe seleccionar la fecha!';
                      }
                    },
                  ),
                  TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Seleccione la hora',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.timer),
                        onPressed: () { _selectTime(context); }
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Debe seleccionar la hora!';
                      }
                    },
                  ),
                  ListTile(
                    title: Text('Selecione el tipo de servicio'),
                    trailing: DropdownButton(
                      value: selectedServiceType,
                      items: itemsServiceType,
                      onChanged: (value) {
                        selectedServiceType = value;
                        setState(() {
                                                
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Selecione el metodo de pago'),
                    trailing: DropdownButton(
                      value: selectedPaymentMethod,
                      items: itemsPaymentMethod,
                      onChanged: (value) {
                        selectedPaymentMethod = value;
                        setState(() {
                                                
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child:  Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.zoom_out_map),
                          Padding(
                            child: Text("Direccion para el servicio", style: TextStyle(fontFamily: 'Roboto',color: Color.fromRGBO(68, 68, 76, .8),
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
                              print('error en el formulario');
                            }
                          },
                          color: Colors.lightBlueAccent,
                          child: Text('Solicitar Servicio', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}