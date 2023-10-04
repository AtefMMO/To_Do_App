import 'package:flutter/material.dart';
import 'package:todoapp/app_theme.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  DateTime selectedDate=DateTime.now();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Task title',
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Select Date',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {},
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

  void showCalender() async{
   var choosenDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
   if(choosenDate!=null){
    selectedDate=choosenDate;}
   setState(() {

   });
  }
}
