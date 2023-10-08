import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:todoapp/list_tap/task_model_class.dart';

class FirebaseUtils {
  static CollectionReference<TaskData> getTaskCollection() {//method that returns the collection of tasks in the data base to be able to make action on it
    return FirebaseFirestore.instance.collection(TaskData.collectionName).withConverter<TaskData>(
        fromFirestore: (snapshot, options) =>
            TaskData.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }

 static Future<void> addTaskToFirebase(TaskData task) {//method that adds the task to the database
var collection=getTaskCollection();//make a collection or get it if availble
  var doc=  collection.doc();//make doc of task
    task.id=doc.id;//auto generated id for the doc we need to assign it to the task data class
    return doc.set(task);//add it to the database
  }
}
