class Users {
  String name;
  String email;
  String password;

  Users({required this.name, required this.email, required this.password});
}

class MyUser {
  static const String collectionName = 'user';
  String? name;
  String? email;
  String? id;
  MyUser({required this.email, required this.name, required this.id});
  Map<String, dynamic> toFireStore() {
    return {'name': name, 'email': email, 'id': id};
  }

  MyUser.fromJson(Map<String, dynamic> userData) {
    name = userData['name'];
    email = userData['email'];
    id = userData['id'];
  }
}
