import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/login_screen/firestore_user.dart';

import 'package:todoapp/login_screen/user_data.dart';

import '../providers/auth_provider.dart';

class UserDb {
  static Future<bool> AddUserToDb(Users user) async {
    bool isSuccesful = true;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      await UserFirebaseUtils.addUserToDb(
          MyUser(email: user.email, name: user.name, id: credential.user!.uid));
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

  static Future<String> SignInUserFromDb(
      Users user, BuildContext context) async {
    bool wrongPass = false;
    bool wrongEmail = false;
    try {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      var newUser =
          await UserFirebaseUtils.readUserFromDb(credential.user!.uid);

      authProvider.changeUser(
          MyUser(email: newUser!.email, name: newUser!.name, id: newUser!.id));
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
  static Future<void> deleteUser() async {
    FirebaseAuth.instance.currentUser!.delete();
  }
}
