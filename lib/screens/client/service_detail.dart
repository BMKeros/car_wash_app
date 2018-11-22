import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/models/service.dart';

class ServiceDeatil extends StatefulWidget {
  final FirebaseUser _user;
  final Service _service;

  ServiceDeatil(this._user, this._service);

  @override
  _ServiceDeatilState createState() => new _ServiceDeatilState(_user, _service);
}

class _ServiceDeatilState extends State<ServiceDeatil> {
  // rating service
  final FirebaseUser _currentUser;
  final Service _currentService;

  double rating = 3.5;
  int starCount = 6;
  bool expandedDetail = false;

  _ServiceDeatilState(this._currentUser, this._currentService);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Detalle del Servicio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Datos',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    title: Text('20/02/2018',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(Icons.date_range),
                  ),
                  ListTile(
                    title: Text('8:30 AM',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(Icons.access_time),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Estado:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text('Aceptado'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 7.0, top: 10.0),
                          child: Text("Calificar:",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: StarRating(
                            size: 25.0,
                            rating: rating,
                            color: Colors.orange,
                            borderColor: Colors.grey,
                            starCount: 6,
                            onRatingChanged: (rating) => setState(
                                  () {
                                this.rating = rating;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ExpansionPanelList(
                    children: <ExpansionPanel>[
                      new ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return new ListTile(
                              title: new Text(
                                "Responsable",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ));
                        },
                        isExpanded: expandedDetail,
                        body: new Text(
                          "culito",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                    expansionCallback: (int index, bool isExpanded) {
                      //isExpanded = !expandedDetail;
                      setState(() {
                        this.expandedDetail = !expandedDetail;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
