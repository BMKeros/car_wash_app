import 'package:flutter/material.dart';

Positioned cardDemoDummy(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return Positioned(
    bottom: 100.0 + bottom,
    //right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: Card(
      color: Colors.transparent,
      elevation: 5,
      child: Container(
        //alignment: Alignment.center,
        width: screenSize.width / 1.2 + cardWidth,
        height: screenSize.height / 1.7,
        decoration: BoxDecoration(
          color: Color.fromRGBO(121, 114, 173, 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width / 1.2 + cardWidth,
              height: screenSize.height / 2.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
                image: img,
              ),
            ),
            Container(
              width: screenSize.width / 1.2 + cardWidth,
              height: screenSize.height / 1.7 - screenSize.height / 2.2,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {},
                    child: Container(
                      height: 60.0,
                      width: 130.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Text(
                        "NO",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {},
                    child: Container(
                      height: 60.0,
                      width: 130.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Text(
                        "SI",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    ),
  );
}
