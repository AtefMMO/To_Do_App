import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/login_screen/user_data.dart';

class UserDb {
  static Future<bool> AddUserToDb(Users user) async {
    bool isSuccesful = true;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password
      );

      print('registered succesfully');
      print(credential.user!.uid); //user id
    } on FirebaseAuthException catch (e) {
      isSuccesful = false;
      print(isSuccesful);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    if (isSuccesful) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> SignInUserFromDb(Users user) async {
    bool wrongPass = false;
    bool wrongEmail = false;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      print('sign in success');
      print(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      wrongEmail = true;
      wrongPass = true;
      if (e.code == 'user-not-found') {
        wrongEmail = true;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        wrongPass = true;
        print('Wrong password provided for that user.');
      }
    }
    if (wrongEmail) {
      return 'email';
    }
      if (wrongPass) {
        return 'pass';
      }
        return 'ok';


  }
}
