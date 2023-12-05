import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:todoapp/register_screen/register_navigator.dart';

import '../app_theme.dart';
import '../firebase_auth/firestore_user.dart';
import '../firebase_auth/user_data.dart';

import '../login_screen/login.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  Future<bool> AddUserToDb(Users user) async {
    bool isSuccesful = true;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      await UserFirebaseUtils.addUserToDb(
          MyUser(email: user.email, name: user.name, id: credential.user!.uid));
      navigator.showMessage('registered succesfully');
     // print('registered succesfully');
      print(credential.user!.uid); //user id
    } on FirebaseAuthException catch (e) {
      isSuccesful = false;
      print(isSuccesful);
      if (e.code == 'weak-password') {
        navigator.showMessage('The password provided is too weak.');
      //  print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
       navigator.showMessage('The account already exists for that email.');
       // print('The account already exists for that email.');
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

  void register(Users user) async {
    navigator.showLoading();
  //  LoadingScreen.showLoadingScreen(context, 'Loading...', false);
    if (await AddUserToDb(user)) {
      navigator.hideLoading();
      //Navigator.pop(context);
      navigator.changeScreen(LoginScreen.RouteName);
     // Navigator.pushReplacementNamed(context, LoginScreen.RouteName);
    } else {
      Fluttertoast.showToast(
          msg: "User already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.red,
          textColor: Colors.white,
          fontSize: 16.0);
      navigator.hideLoading();
     // Navigator.pop(context);
    }
  }
}
