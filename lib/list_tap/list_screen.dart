import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:todoapp/list_tap/task.dart';
import 'package:todoapp/list_tap/task_model_class.dart';
import 'package:todoapp/providers/list_provider.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    if (provider.taskList.isEmpty) {
      provider.getTasksFromDb();
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            CalendarTimeline(
              initialDate: provider.selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                provider.changeSelectedDate(date);//now must change init date to
                //this bec on date selected the current date will change but it wonot
                //work in the ui
              //  print(provider.selectedDate);
              },
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Colors.black,
              activeBackgroundDayColor: Colors.white,
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
                task: provider.taskList[index],
              );
            },
            itemCount: provider.taskList.length,
          ),
        )
      ],
    );
  }
}
