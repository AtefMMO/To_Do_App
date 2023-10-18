import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:todoapp/login_screen/add_user_to_db.dart';
import 'package:todoapp/login_screen/firestore_user.dart';
import 'package:todoapp/login_screen/login.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/settings_tap/theme_sheet.dart';

import '../providers/auth_provider.dart';
import '../providers/list_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Mode',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        InkWell(
          onTap: () {
            showThemeSheet(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appTheme == ThemeMode.light
                      ? 'Light Mode'
                      : 'Dark Mode',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'User Info',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.1,
                horizontal: MediaQuery.of(context).size.height * 0.040),
            decoration: BoxDecoration(
                color: provider.appTheme==ThemeMode.light?AppTheme.white:Colors.grey, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Name : ${authProvider.currentUser!.name}',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(
                  height: 10,
                ),
                Text('Email : ${authProvider.currentUser!.email}',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(
                  height: 10,
                ),
                Text('Id : ${authProvider.currentUser!.id}',
                    style: Theme.of(context).textTheme.titleMedium),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              listProvider.taskList=[];
                              listProvider.selectedDate=DateTime.now();
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.RouteName);
                            },
                            child: Text(
                              'Sign out',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor)),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Are you sure you want to delete your account?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: AppTheme.red),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    UserFirebaseUtils
                                                        .deleteUserFromDb(
                                                            authProvider
                                                                .currentUser!);
                                                    UserDb.deleteUser();

listProvider.taskList=[];
listProvider.selectedDate=DateTime.now();
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            LoginScreen
                                                                .RouteName);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: Text(
                              'Delete Account',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.red))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void showThemeSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => ThemeSheet());
  }
}
