import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/list_tap/add_task_to_firebase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../list_tap/task_model_class.dart';
import '../providers/list_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  var formKey=GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title='',description='';
//late ListProvider provider;
  Widget build(BuildContext context) {
     //provider =Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
              padding: EdgeInsets.all(25),
              child: Form(
                key:formKey ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Task title',
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black))
                      ),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return 'Invalid Task title';
                        }
                      },onChanged: (value) {
                        title=value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Task description',
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return 'Invalid Task description';
                        }
                      },
                      onChanged: (value) {
                        description=value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Select Date',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                          onPressed: () {
                            addTask();

                          },
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 18),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }
  void addTask(){
    if(formKey.currentState!.validate()){
     var provider =Provider.of<ListProvider>(context,listen: false);
      TaskData task=TaskData(title:title ,
          description:description ,
          date:selectedDate );
FirebaseUtils.addTaskToFirebase(task).timeout(Duration(milliseconds: 500),onTimeout:
    () {
  print('Task Added Successfully');
  Navigator.pop(context);
  provider.getTasksFromDb();
  Fluttertoast.showToast(
      msg: "Task Added Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
},);
    }
  }
}
