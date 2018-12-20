import 'package:flutter/material.dart';
import 'package:panelmex_app/models/service.dart';
import 'package:panelmex_app/screens/client/service_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:panelmex_app/widgets/dialog_loading.dart';

class CardService extends StatelessWidget {
  final Service service;

  CardService({Key key, this.service}) : super(key: key);
  DatabaseReference _serviceRef =
      FirebaseDatabase.instance.reference().child('services');

  Icon getIconStatus(String status) {
    IconData icon;
    MaterialColor color;

    switch (status) {
      case 'pending':
        icon = Icons.timer;
        color = Colors.orange;
        break;
      case 'accepted':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'refused':
        icon = Icons.close;
        color = Colors.red;
        break;
      default:
        icon = Icons.timer;
        color = Colors.orange;
        break;
    }

    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 15, right: 10, left: 10),
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 248, 255, .9),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Container(
            padding: EdgeInsets.only(right: 12),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1, color: Colors.black),
              ),
            ),
            child: getIconStatus(service.status),
          ),
          title: Text(
            service.type,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  // tag: 'hero',
                  child: Text(service.parseTime,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    service.date,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          trailing:IconButton(
            icon: Icon(Icons.settings, color: Colors.black38, size: 20),
            onPressed: () {
              _settingModalBottomSheet(context);
            },
          ),
              
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceDetail(null, service),
              ),
            );
          },
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.cancel, color: Colors.redAccent[200], size: 20),
                title: new Text('Cancelar servicio'),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DialogLoading(message: "Cancelando servicio");
                    },
                  );
                  _serviceRef
                    .child('/${service.key}')
                    .update({
                      'status': 'refused'
                    })
                    .then((x) {
                       Navigator.pop(context);
                        Navigator.pop(context);
                    });
                },    
              ),
            ],
          ),
        );
      }
    );
  }
}

