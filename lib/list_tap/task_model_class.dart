class TaskData {
  //data class used to save task in the data base
  static const String collectionName = 'Tasks';
  String? id;
  String? title;
  String? description;
  DateTime? date;
  bool? isDone;
  TaskData(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});
  Map<String, dynamic> toJson() {
    //convert class data to json so we can save it on firebase
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch, //time since 1970 in sec
      'isDone': isDone
    };
  }

  TaskData.fromJson(Map<String, dynamic> taskData) {
    id = taskData['id'] as String?;
    title = taskData['title'];
    description = taskData['description'];
    date = DateTime.fromMillisecondsSinceEpoch(taskData['date']);
    isDone = taskData['isDone'];
  }
}
