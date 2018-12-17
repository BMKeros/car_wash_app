import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panelmex_app/models/profile.dart';
import 'package:panelmex_app/screens/client/profile.dart';
import 'package:panelmex_app/widgets/dialog_loading.dart';
class EditProfile extends StatefulWidget {

  String _tittle;
  String _labelTextField;
  List<String> _data;
  final FirebaseUser _currentUser;
  EditProfile(this._tittle, this._labelTextField, this._data, this._currentUser);

  @override
  _EditProfileState createState() => _EditProfileState(this._tittle, this._labelTextField, this._data, this._currentUser);
 }

class _EditProfileState extends State<EditProfile> {
  String _tittle;
  List<String> _data;
  String _labelTextField;
  final FirebaseUser _currentUser;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  Profile _profile = Profile('', '', '', '', '', '');
  DatabaseReference _profileRef =
      FirebaseDatabase.instance.reference().child('users');
  _EditProfileState(this._tittle, this._labelTextField, this._data, this._currentUser);

  @override
  void initState() {
    super.initState();

    if (_data.length  < 2) {
      // Solo vendria un valor por lo cual podria ser la direccion o el numero
      switch(_labelTextField) {
        case 'Direccion':
          _addressController.text = _data[0];
          break;
        
        case 'Numero':
          _phoneNumberController.text = _data[0];
          break;
      }
    }
    else if(_data.length > 1) {
      // Si viene mas de un campo entonces deberia ser el nombre y el apellido
      _firstNameController.text = _data[0];
      _lastNameController.text = _data[1];
    }
  }

  Widget customAppBar(ctx) { 
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.of(ctx).pop();
        },
      ),
      iconTheme: new IconThemeData(
        color: Colors.white,
      ),
      title: Text(
        _tittle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget editNames (ctx) {
    return Scaffold(
      appBar: customAppBar(ctx),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Nombre'),
              controller: _firstNameController,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Apellido'),
              controller: _lastNameController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogLoading(message: "Guardando cambios");
            },
          );
          _profileRef
            .child('/${_currentUser.uid}/profile')
            .update({
              'first_name': _firstNameController.text,
              'last_name': _lastNameController.text
            })
            .then((x) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(_currentUser))
              );
            });
        }
      ),
    );
  }

  Widget editInfoContact(ctx) {
    return Scaffold(
      appBar: customAppBar(ctx),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: _labelTextField),
              controller: _labelTextField == 'Numero' ? _phoneNumberController : _addressController,
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogLoading(message: "Guardando cambios");
            },
          );
          switch(_labelTextField) {
            case 'Numero':
              _profileRef
              .child('/${_currentUser.uid}/profile')
              .update({ 
                'phone_number': _phoneNumberController.text 
                })
              .then((x) {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(_currentUser))
                );
              });
              break;
            case 'Direccion':
              _profileRef
              .child('/${_currentUser.uid}/profile')
              .update({ 
                'address': _addressController.text 
                })
              .then((x) {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(_currentUser))
                );
              });
              break;
          }
        },
      ),
    );
  } 

  @override
  Widget build(BuildContext context) {
    return _data.length > 1 ? editNames(context) : editInfoContact(context);
  }
}