import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:panelmex_app/screens/admin/swipe_animation/data.dart';
import 'package:panelmex_app/screens/admin/swipe_animation/activeCard.dart';
import 'package:panelmex_app/screens/admin/swipe_animation/dummyCard.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => new _HomeCardState();
}

class _HomeCardState extends State<HomeCard> with TickerProviderStateMixin {

  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;

  List data = imageData;
  List selectedData = [];
  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);
          print('rotacion completa');
          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    print('culito');
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    print('papito');
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'Administracion Panelmex', 
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold
                ),
              ),
              accountEmail: Text(
                'admin@gmail.com',
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey
                /*image:  DecorationImage(
                  image: AssetImage('assets/dream-car.png'),
                  fit: BoxFit.fill
                )*/
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              leading: Icon(Icons.home),
              onTap: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(
        //elevation: 0.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        //actions: ,
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SERVICIOS",
                style: new TextStyle(
                    fontSize: 12.0,
                    letterSpacing: 3.5,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 15.0,
                height: 15.0,
                margin: new EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                child: new Text(
                  dataLength.toString(),
                  style: new TextStyle(fontSize: 10.0),
                ),
                decoration: new BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: dataLength > 0
            ?  Stack(
                alignment: AlignmentDirectional.center,
                children: data.map((item) {
                  if (data.indexOf(item) == dataLength - 1) {
                    print(item);
                    return cardDemo(
                        item,
                        bottom.value,
                        right.value,
                        0.0,
                        backCardWidth + 10,
                        rotate.value,
                        rotate.value < -10 ? 0.1 : 0.0,
                        context,
                        dismissImg,
                        flag,
                        addImg,
                        swipeRight,
                        swipeLeft);
                  } else {
                    backCardPosition = backCardPosition - 10;
                    backCardWidth = backCardWidth + 10;

                    return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                        backCardWidth, 0.0, 0.0, context);
                  }
                }).toList())
            : new Text("No hay servicios.",
                style: new TextStyle(color: Colors.white, fontSize: 50.0)),
      )
    );
  }
}