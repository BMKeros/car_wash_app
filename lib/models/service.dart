import 'package:firebase_database/firebase_database.dart';

class Service {
  String _key;
  String _type;
  String _date;
  String _time;

  Service(this._key, this._type, this._date, this._time);

  String get key => _key;

  String get type => _type;

  String get date => _date;

  String get time => _time;

  Service.fromSnapshot(DataSnapshot snapshot) {
    print(snapshot.value);
    _key = snapshot.key;
    _type = snapshot.value['type'];
    _date = snapshot.value['date'];
    _time = snapshot.value['time'];
  }
}
