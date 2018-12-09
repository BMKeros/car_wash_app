import 'package:flutter/material.dart';
import 'package:panelmex_app/models/service.dart';
import 'package:panelmex_app/screens/client/service_detail.dart';

class CardService extends StatelessWidget {
  final Service service;

  CardService({Key key, this.service}) : super(key: key);

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
      case 'cancelled':
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
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black),
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
                flex: 4,
                child: Container(
                  // tag: 'hero',
                  child: Text(service.parseTime,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    service.date,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
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
}
