import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  static String routerName = '/profile';

  final FirebaseUser _currentUser;

  Profile(this._currentUser);

  @override
  _ProfileState createState() => new _ProfileState(this._currentUser);
}
class _ProfileState extends State<Profile> {
  final FirebaseUser _currentUser;

  _ProfileState(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                Hero(
                  tag: 'assets/avatars/avatar-4.jpg',
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/avatars/avatar-4.jpg')
                      )
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text(
                  'Vanesa Castro',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Santa Barbara',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.grey
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Pendientes',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '22',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Aceptados',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Rechazados',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.blueGrey
                        ),
                        title: Text(
                          "prueba@gmail.com",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.blueGrey
                        ),
                        title: Text(
                          "+58-4165625564",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                /*buildImages(),
                buildInfoDetail(),
                buildImages(),
                buildInfoDetail(),*/
              ],
            )
            /*Container(
              padding: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                child: Image.asset('assets/avatars/avatar-4.jpg', height: 150,),
                backgroundColor: Colors.grey[100],
                radius: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                leading: Icon(
                  Icons.people
                ),
                title: Text("Vanesa Castro"),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.email
              ),
              title: Text("prueba@gmail.com"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.phone
              ),
              title: Text("+58-4165625564"),
            ),*/
          ],
        ),
      ),
    );
  }
  Widget buildImages() {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage('assets/img5.jpg'),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }

  Widget buildInfoDetail() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Fiesta - 1 dia',
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7,),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: 'Montserrat',
                      fontSize: 11
                    ),
                  ),
                  SizedBox(width: 4,),
                  Icon(
                    Icons.timer,
                    size: 4,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4,),
                  Text(
                    '3 Videos',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontFamily: 'Montserrat',
                      fontSize: 11
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}