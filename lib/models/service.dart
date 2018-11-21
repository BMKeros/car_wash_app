import 'package:firebase_database/firebase_database.dart';

class Service {
  String _key;
  String _type;
  String _date;
  String _time;
  String _uid;
  String _status;

  Service(this._key, this._uid, this._type, this._date, this._time,
      this._status);

  String get key => _key;

  String get type => _type;

  String get date => _date;

  String get time => _time;

  String get uid => _uid;

  String get status => _status;

  Service.fromSnapshot(DataSnapshot snapshot) {
    print(snapshot.value);
    _key = snapshot.key;
    _uid = snapshot.value['uid'];
    _type = snapshot.value['type'];
    _date = snapshot.value['date'];
    _time = snapshot.value['time'];
    _status = snapshot.value['status'];
  }
}
