class Profile {
  String email;
  String firstName;
  String lastName;
  String address;
  String phoneNumber;

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
