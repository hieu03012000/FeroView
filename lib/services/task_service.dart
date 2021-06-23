import 'dart:convert';

import 'package:fero/models/task.dart';
import 'package:fero/utils/constants.dart';
import 'package:http/http.dart' as http;

class TaskService {
  List<Task> parseTaskList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> getTaskList(String modelId, DateTime start, DateTime end) async {

    Map<String, dynamic> params = Map<String, dynamic>();
    params['beginTime'] = start;
    params['endTime'] = end;

    final response =
    await http.post(Uri.parse(baseUrl + "api/v1/models/" + modelId + "/tasks"),
    body: params, headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}