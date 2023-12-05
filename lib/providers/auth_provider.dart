import 'package:flutter/foundation.dart';

import '../firebase_auth/user_data.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? currentUser;
  void changeUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
