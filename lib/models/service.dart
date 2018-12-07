import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Service {
  String _key;
  String _type;
  String _date;
  String _time;
  String _uid;
  String _status;
  String _created_date;
  String _static_map_uri;
  String _washing_type;
  String _payment_method;
  String _vehicle_type;
  String _responsible_key;
  double _latitude;
  double _longitude;

  Service(this._key,
      this._uid,
      this._type,
      this._date,
      this._time,
      this._status,
      this._created_date,
      this._static_map_uri,
      this._washing_type,
      this._payment_method,
      this._vehicle_type,
      this._latitude,
      this._longitude,
      this._responsible_key);

  String get key => _key;

  String get type => _type;

  String get date => _date;

  String get time => _time;

  String get parseTime => timeTo12HrFormat(_time);

  String get uid => _uid;

  String get status => _status;

  String get createdDate => _created_date;

  String get staticMapUri => _static_map_uri;
  
  String get washingType => _washing_type;

  String get paymentMethod => _payment_method;

  String get vehicleType => _vehicle_type;

  double get latitude => _latitude;

  double get longitude => _longitude;

  Service.fromSnapshot(DataSnapshot snapshot) {
    _key = snapshot.key;
    _uid = snapshot.value['uid'];
    _type = snapshot.value['type'];
    _date = snapshot.value['date'];
    _time = snapshot.value['time'];
    _status = snapshot.value['status'];
    _created_date = snapshot.value['created_date'];
    _static_map_uri = snapshot.value['static_map_uri'];
    _washing_type = snapshot.value['washing_type'];
    _payment_method = snapshot.value['payment_method'];
    _latitude = snapshot.value['latitude'];
    _longitude = snapshot.value['longitude'];
    _responsible_key = snapshot.value['responsibleKey'];
  }
}

String timeTo12HrFormat(String time) {   // Take a time in 24 hour format and format it in 12 hour format
    List<String> time_part_array = time.split(":");
    var ampm = 'AM';

    if (int.parse(time_part_array[0]) >=  12) {
        ampm = 'PM';
    }

    if (int.parse(time_part_array[0]) > 12) {
      int currenTime = int.parse(time_part_array[0]) - 12;
      time_part_array[0] = currenTime.toString();
    }

    String formatted_time = time_part_array[0] + ':' + time_part_array[1] + ':' + time_part_array[2] + ' ' + ampm;

    return formatted_time;
}