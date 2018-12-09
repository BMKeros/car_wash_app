import 'package:firebase_database/firebase_database.dart';

class Responsible {
  String _key;
  String _identification;
  String _first_name;
  String _last_name;
  String _image_url;
  String _phone;

  Responsible(this._key, this._identification, this._first_name, this._last_name, this._image_url, this._phone);

  String get key => this._key;
  String get identification => this._identification;
  String get firstName => this._first_name;
  String get lastName => this._last_name;
  String get imageUrl => this._image_url;
  String get phone => this._phone;
  String get fullName => '${this._first_name} ${this._last_name}';

  Responsible.fromSnapshot(DataSnapshot snapshot) {
    _key = snapshot.key;
    _identification = snapshot.value['identification'];
    _first_name = snapshot.value['first_name'];
    _last_name = snapshot.value['last_name'];
    _image_url = snapshot.value['image_url'];
    _phone = snapshot.value['phone'];
  }
}