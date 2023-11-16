import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:todoapp/list_tap/task.dart';
import 'package:todoapp/list_tap/task_model_class.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/providers/list_provider.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late ListProvider listProvider;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    listProvider = Provider.of<ListProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    listProvider.getTasksFromDb(authProvider.currentUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            CalendarTimeline(
              initialDate: listProvider.selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                listProvider.changeSelectedDate(
                    date,
                    authProvider
                        .currentUser!.id!); //now must change init date to
                //this bec on date selected the current date will change but it wonot
                //work in the ui
                //  print(provider.selectedDate);
              },
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Colors.black,
              activeBackgroundDayColor: provider.appTheme == ThemeMode.light
                  ? Colors.white
                  : Colors.grey,
              dotsColor: Color(0xFF333A47),
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
              dayNameColor: Colors.black,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Task(
                task: listProvider.taskList[index],
              );
            },
            itemCount: listProvider.taskList.length,
          ),
        )
      ],
    );
  }
}
