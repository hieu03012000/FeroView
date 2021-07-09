import 'dart:convert';

import 'package:fero/models/task.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskService {
  List<Task> parseTaskList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> getTaskList() async {
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/models/" + modelId + "/tasks"));
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Task>> getIncomingTaskList(int castingId) async {
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "/api/v1/tasks/$modelId/$castingId/task"));
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<bool> createFreeTime(Map<String, dynamic> params) async {
    final message = jsonEncode(params);
    final response = await http.post(
        Uri.parse(
            baseUrl + 'api/v1/tasks/free-time'),
        body: message,
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      // var responseBody = Task.fromJson(jsonDecode(response.body));
      // return responseBody;
      Fluttertoast.showToast(msg: 'Create success');
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Can not create');
      return false;
    }
  }
}

List<Appointment> getAppointment(TaskListViewModel list) {
  List<Appointment> task = <Appointment>[];
  for (int i = 0; i < list.tasks.length; i++) {
    task.add(Appointment(
        startTime: list.tasks[i].startAt,
        endTime: list.tasks[i].endAt,
        color: kPrimaryColor,
        subject: list.tasks[i].castingName == null
            ? 'Free time'
            : list.tasks[i].castingName));
  }
  return task;
}
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
