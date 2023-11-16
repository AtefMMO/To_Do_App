import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:todoapp/list_tap/edit_screen.dart';
import 'package:todoapp/list_tap/task_model_class.dart';
import '../providers/auth_provider.dart';
import '../providers/list_provider.dart';

class Task extends StatelessWidget {
  TaskData task;

  Task({required this.task});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                var authProvider=Provider.of<AuthProvider>(context,listen: false);
                FirebaseUtils.deleteData(task,authProvider.currentUser!.id!);//deletes task from db
                provider.getTasksFromDb(authProvider.currentUser!.id!);
                Fluttertoast.showToast(
                    msg: "Task Deleted Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppTheme.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              backgroundColor: AppTheme.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),


              ),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: BorderRadius.only(topRight:Radius.circular(12) ,bottomRight: Radius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.01,
                decoration: BoxDecoration(
                    color: task.isDone!?AppTheme.green:Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        task.title??'',
                        style: task.isDone!?Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.green):Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(task.isDone!?'Done!':task.description??'',
                           style:task.isDone!?Theme.of(context).textTheme.titleMedium!.copyWith(color:AppTheme.green): Theme.of(context)
                              .textTheme
                              .titleSmall
                              )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: task.isDone!?false:true,
                    child: InkWell(
                      onTap: () {
                        var authProvider=Provider.of<AuthProvider>(context,listen: false);
                        task.isDone=true;
                        FirebaseUtils.updateData(task,authProvider.currentUser!.id!);
                        provider.getTasksFromDb(authProvider.currentUser!.id!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Icon(Icons.check, color: AppTheme.white, size: 25),
                        ),
                      ),
                    ),
                  ), Visibility(
                    visible: task.isDone!?false:true,
                    child: InkWell(
                      onTap: () {
                        showEditScreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              color: AppTheme.grey,
                              borderRadius: BorderRadius.circular(6)),
                          child: Icon(Icons.edit, color: AppTheme.white, size: 20),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showEditScreen(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => EditScreen(task: task,));
  }
}
