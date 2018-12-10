import 'package:flutter/material.dart';
import 'package:panelmex_app/common/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/models/service.dart';
import 'package:panelmex_app/models/responsible.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceDetail extends StatefulWidget {
  final FirebaseUser _user;
  final Service _service;

  ServiceDetail(this._user, this._service);

  @override
  _ServiceDetailState createState() => new _ServiceDetailState(_user, _service);
}

class _ServiceDetailState extends State<ServiceDetail> {
  final FirebaseUser _currentUser;
  final Service _currentService;

  double rating = 3.5;
  int starCount = 6;
  bool expandedDetail = false;
  bool _showCardResposible = false;
  Responsible _responsible;

  DatabaseReference _responsiblesRef =
  FirebaseDatabase.instance.reference().child('responsibles');

  _ServiceDetailState(this._currentUser, this._currentService);

  @override
  void initState() {
    super.initState();

    if (_currentService.hasResponsible) {
      _responsiblesRef
          .child('/${_currentService.responsibleKey}')
          .once()
          .then((snapshot) {
        setState(() {
          _responsible = Responsible.fromSnapshot(snapshot);
          _showCardResposible = true;
        });
      });
    }
  }

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
          //padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                imageUrl: getStaticMapBox(_currentService.latitude,
                    _currentService.longitude, '620', '620'),
                placeholder: Container(
                  constraints: BoxConstraints.expand(),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: new Icon(Icons.error),
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(_currentService.date,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(Icons.date_range),
                  ),
                  ListTile(
                    title: Text(_currentService.parseTime,
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
                        Text(getNameStatus(_currentService.status)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text("Tipo:",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text(_currentService.type)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            _showCardResposible
                ? Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ExpansionPanelList(
                      children: <ExpansionPanel>[
                        new ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return new ListTile(
                              title: new Text(
                                "Responsable",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                          isExpanded: expandedDetail,
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: 'assets/avatars/avatar-4.jpg',
                                child: Container(
                                  height: 125,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(62.5),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        _responsible.imageUrl
                                      )
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                _responsible.fullName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                               SizedBox(
                                height: 20,
                              ),
                            ],
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
              ),
            )
                : Text('')
          ],
        ),
      ),
    );
  }
}
