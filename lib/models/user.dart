class User {
  String uid;
  String email;

  User(this.uid, this.email);

  @override
  String toString() {
    return "$uid";
  }
}
