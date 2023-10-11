import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:todoapp/list_tap/task.dart';
import 'package:todoapp/list_tap/task_model_class.dart';
import 'package:todoapp/providers/list_provider.dart';

import '../app_theme.dart';

class EditScreen extends StatefulWidget {
  TaskData task;
  EditScreen({required this.task});
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Edit Task',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.task.title = value!;
                        },
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter Task title',
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                        initialValue: widget.task.title!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter title';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.task.description = value;
                        },
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter Task description',
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                        initialValue: widget.task.description,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter description';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Date',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.task.date!.month}/${widget.task.date!.day}/${widget.task.date!.year}',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var provider = Provider.of<ListProvider>(context,listen: false);//because called provider inside function
//now we should change task in db
                    FirebaseUtils.updateData(widget.task);
                    Navigator.pop(context);
                    provider.getTasksFromDb();
                    Fluttertoast.showToast(
                        msg: "Task Edited Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppTheme.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.titleLarge,
                )),
          )
        ],
      ),
    );
  }

  void showCalender(BuildContext context) async {
    Future<DateTime?> selectedDate = showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedDate != null) {
      widget.task.date = await selectedDate ?? DateTime.now();

      setState(() {});
    }
  }
}
