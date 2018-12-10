import 'package:firebase_database/firebase_database.dart';

class Profile {
  String _key;
  String _first_name;
  String _last_name;
  String _image_url;
  String _address;
  String _phone_number;

  String get key => _key;

  String get firstName => _first_name;

  String get lastName => _last_name;

  String get imageUrl => _image_url;

  String get address => _address;

  String get phoneNumber => _phone_number;

  @override
  String toString() {
    return "$_first_name} ${_last_name}";
  }

  Profile.fromSnapshot(DataSnapshot snapshot) {
    _key = snapshot.key;
    _address = snapshot.value['address'];
    _first_name = snapshot.value['first_name'];
    _last_name = snapshot.value['last_name'];
    _image_url = snapshot.value['image_url'];
    _phone_number = snapshot.value['phone_number'];
  }
}
