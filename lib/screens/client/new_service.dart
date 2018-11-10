import 'package:flutter/material.dart';

class NewService extends StatefulWidget {
  @override
  _NewServiceState createState() => new _NewServiceState();
 }
class _NewServiceState extends State<NewService> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white,),
        title: Text('Panelmex', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}