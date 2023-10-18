import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapp/login_screen/add_user_to_db.dart';
import 'package:todoapp/login_screen/custom_text_form_field.dart';
import 'package:todoapp/login_screen/loading_screen.dart';
import 'package:todoapp/login_screen/login.dart';
import 'package:todoapp/login_screen/user_data.dart';

import '../app_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String RouteName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObsecure = true;
  bool isObsecureConfirm = true;
  String? passString;
  Users user = Users(name: '', email: '', password: '');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.04),
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
                      onChanged: (value) => user.name = value ?? '',
                      label: 'User Name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter user name';
                        }
                      },
                    ),
                    CustomTextFormField(
                        onChanged: (value) => user.email = value ?? '',
                        keyboardType: TextInputType.emailAddress,
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
                        }),
                    CustomTextFormField(
                      onChanged: (value) => user.password = value ?? '',
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Password',
                      icon: InkWell(
                          onTap: () {
                            if (isObsecure == false) {
                              isObsecure = true;
                            } else {
                              isObsecure = false;
                            }
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye_rounded)),
                      isObsecure: isObsecure,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter Password';
                        }
                        if (value.length < 6 || value.length > 30) {
                          return 'password should be larger than 6';
                        }
                        passString = value;
                      },
                    ),
                    CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Confirm Password',
                        isObsecure: isObsecureConfirm,
                        icon: InkWell(
                          child: Icon(Icons.remove_red_eye_rounded),
                          onTap: () {
                            if (isObsecureConfirm == false) {
                              isObsecureConfirm = true;
                            } else {
                              isObsecureConfirm = false;
                            }
                            setState(() {});
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please confirm password';
                          }
                          if (passString != value) {
                            return 'password mismatch';
                          }
                        }),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                     LoadingScreen.showLoadingScreen(context, 'Loading...', false);
                      if (await UserDb.AddUserToDb(user)) {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.RouteName);
                      } else {
                        Fluttertoast.showToast(
                            msg: "User already exist",
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
                    'Register',
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
                  Text('Already have an account?',style: Theme.of(context).textTheme.titleSmall,),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.RouteName);
                      },
                      child: Text(
                        ' Login',
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
