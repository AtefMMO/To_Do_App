import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home_screen/home_screen.dart';
import 'package:todoapp/login_screen/add_user_to_db.dart';
import 'package:todoapp/login_screen/loading_screen.dart';
import 'package:todoapp/login_screen/register.dart';
import 'package:todoapp/login_screen/user_data.dart';

import '../app_theme.dart';
import '../providers/auth_provider.dart';
import 'custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String RouteName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Users user = Users(name: '', email: '', password: '');
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Login'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => user.email = value ?? '',
                      label: 'Email',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'invalid email';
                        }
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) => user.password = value ?? '',
                      label: 'Password',
                      icon: InkWell(
                        child: Icon(Icons.remove_red_eye_rounded),
                        onTap: () {
                          if (isObsecure == false) {
                            isObsecure = true;
                          } else {
                            isObsecure = false;
                          }
                          setState(() {});
                        },
                      ),
                      isObsecure: isObsecure,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter Password';
                        }
                      },
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {

                      LoadingScreen.showLoadingScreen(
                          context, 'Loading...', false);
                      String s = await UserDb.SignInUserFromDb(user,context);
                      if (s == 'ok') {

                        Fluttertoast.showToast(
                            msg: "Login Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppTheme.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.RouteName);
                      } else if (s == 'email') {
                        Fluttertoast.showToast(
                            msg: "invalid User Credentials",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppTheme.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "invalid User Credentials",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppTheme.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',style: Theme.of(context).textTheme.titleSmall,),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.RouteName);
                      },
                      child: Text(
                        ' Register',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
