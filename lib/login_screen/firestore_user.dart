import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/login_screen/user_data.dart';

import '../list_tap/task_model_class.dart';

class UserFirebaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }
 static Future<void> addUserToDb(MyUser user){
    return getUserCollection().doc(user.id).set(user);
  }
 static Future<MyUser?>readUserFromDb(String id)async{
   var doc =await getUserCollection().doc(id).get();
   return doc.data();
  }
  static Future<void> deleteUserFromDb(MyUser user)  {

getUserCollection().doc(user.id).collection(TaskData.collectionName).doc().delete();
    return getUserCollection().doc(user.id).delete();
  }
}
