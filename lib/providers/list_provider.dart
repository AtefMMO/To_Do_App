import 'package:flutter/material.dart';

import '../list_tap/add_task_to_firebase.dart';
import '../list_tap/task_model_class.dart';

class ListProvider extends ChangeNotifier {
  List<TaskData> taskList = [];
  DateTime selectedDate = DateTime.now();
  getTasksFromDb() async {
    taskList = await FirebaseUtils.getTaskFromFireBase();

    taskList = taskList.where((task) {
      if (task.date?.day == selectedDate.day &&
          task.date?.month == selectedDate.month &&
          task.date?.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();
    taskList.sort(
      (TaskData t1, TaskData t2) {
        return t1.date!
            .compareTo(t2.date!); //0 equal 1 first bigger -1 second bigger
      },
    );
    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getTasksFromDb();
    notifyListeners();
  }
}
