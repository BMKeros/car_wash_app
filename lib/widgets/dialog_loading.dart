import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return new Dialog(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          new CircularProgressIndicator(),
          new Text("Please Wait.."),
        ],
      ),
    );*/

    return AlertDialog(
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Spacer(flex: 7),
          new Text("Please Wait.."),
        ],
      ),
    );
  }
}
