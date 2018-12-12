import 'package:firebase_database/firebase_database.dart';

class Profile {
  String _key;
  String _first_name;
  String _last_name;
  String _image_url;
  String _address;
  String _phone_number;

  Profile(this._key, this._first_name, this._last_name, this._image_url,
      this._phone_number, this._address);

  String get key => _key;

  String get firstName => _first_name;

  String get lastName => _last_name;

  String get imageUrl => _image_url;

  bool get hasImage => _image_url != null && _image_url.isNotEmpty;

  String get address => _address;

  String get phoneNumber => _phone_number;

  @override
  String toString() {
    return "$_first_name $_last_name";
  }

  Profile.fromSnapshot(DataSnapshot snapshot) {
    _key = snapshot.key;
    _address = snapshot.value['address'] ?? '';
    _first_name = snapshot.value['first_name'] ?? '';
    _last_name = snapshot.value['last_name'] ?? '';
    _image_url = snapshot.value['image_url'] ?? '';
    _phone_number = snapshot.value['phone_number'] ?? '';
  }
}
