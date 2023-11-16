import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/home_screen/add_task_screen.dart';
import 'package:todoapp/list_tap/list_screen.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/settings_tap/settings_screen.dart';

import '../providers/auth_provider.dart';
import '../providers/list_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String RouteName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  int selectedIndex = 0;

  List<Widget> tapsList = [ListScreen(), SettingsScreen()];
  Widget build(BuildContext context) {
   var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        selectedIndex == 0
            ? 'To DO List ${authProvider.currentUser!.name}'
            : 'Settings',
        style: Theme.of(context).textTheme.titleLarge,
      )),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        shape: StadiumBorder(
            side: BorderSide(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : Colors.grey,
                width: 4)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tapsList[selectedIndex],
    );
  }

  ShowAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskScreen());
  }
}
