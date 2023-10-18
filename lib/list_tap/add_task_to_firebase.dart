

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/list_tap/task_model_class.dart';
import 'package:todoapp/login_screen/firestore_user.dart';

import '../login_screen/add_user_to_db.dart';

class FirebaseUtils {

  static CollectionReference<TaskData> getTaskCollection(String uid) {
    //method that returns the collection of tasks in the data base to be able to make action on it
    return UserFirebaseUtils.getUserCollection().doc(uid)
        .collection(TaskData.collectionName)
        .withConverter<TaskData>(
            fromFirestore: (snapshot, options) =>
                TaskData.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addTaskToFirebase(TaskData task,String uid) {
    //method that adds the task to the database
    var collection =
        getTaskCollection(uid); //make a collection or get it if available
    var doc = collection.doc(); //make doc of task
    task.id = doc
        .id; //auto generated id for the doc we need to assign it to the task data class

    return doc.set(task); //add it to the database
  }

  static Future<List<TaskData>> getTaskFromFireBase(String uid) async {
    List<TaskData> tasks = [];
    QuerySnapshot<TaskData> snapshot = await getTaskCollection(uid)
        .get(); //gets all the documents in the collection
    tasks = snapshot.docs
        .map((doc) => doc.data())
        .toList(); //takes the data inside each document and adds them to list of type task data
    return tasks;
  }
  static void updateData(TaskData task,String uid){
    var collection =
    getTaskCollection(uid);
    var doc=collection.doc(task.id);//gets the specific document with the task id
    doc.update(task.toJson());//updates the documents
}
static void deleteData(TaskData task,String uid){
    var collection=getTaskCollection(uid);
    var doc=collection.doc(task.id);//deletes the task by its id
    doc.delete();//deletes task
}
}
