import 'package:fero/models/task.dart';
import 'package:fero/services/task_service.dart';
import 'package:fero/viewmodels/model_task_view_model.dart';
import 'package:flutter/material.dart';

class TaskListViewModel with ChangeNotifier {
   List<ModelTaskViewModel> tasks = List<ModelTaskViewModel>();
  
  Future<TaskListViewModel> getTaskList(String modelId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Task> list = await TaskService().getTaskList(modelId);
      notifyListeners();
      this.tasks = list.map((tasks) => ModelTaskViewModel(task: tasks)).toList();
    });
  }
}
