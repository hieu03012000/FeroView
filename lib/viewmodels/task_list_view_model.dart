import 'package:fero/models/task.dart';
import 'package:fero/services/task_service.dart';
import 'package:fero/viewmodels/model_task_view_model.dart';
import 'package:flutter/material.dart';

class TaskListViewModel with ChangeNotifier {
  List<ModelTaskViewModel> tasks = List<ModelTaskViewModel>();

  void topHeadlines(String modelId, DateTime start, DateTime end) async {
    List<Task> list = await TaskService().getTaskList(modelId, start, end);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    this.tasks =
        list.map((tasks) => ModelTaskViewModel(task: tasks)).toList();
  }
}
