import 'dart:convert';

import 'package:fero/models/model.dart';
import 'package:fero/utils/constants.dart';
import 'package:http/http.dart' as http;

class ModelService {
  Future<Model> getModelDetail(String modelId) async {
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/models/" + modelId));
    if (response.statusCode == 200) {
      var model = Model.fromJsonDetail(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Model> updateModelDetail(Map<String, dynamic> params) async {
    final message = jsonEncode(params);
    final response = await http.put(
        Uri.parse(
            baseUrl + 'api/v1/models/${params["id"]}/profile'),
        body: message,
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      var responseBody = Model.fromJsonDetail(jsonDecode(response.body));
      return responseBody;
    } else {
      throw Exception('Failed to load');
    }
  }

  List<Model> parseModelList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final list = parsed.map<Model>((json) => Model.fromJson(json)).toList();
    return list;
  }

  Future<List<Model>> getModelList() async {
    final response =
        await http.get(Uri.parse(baseUrl + "api/v1/models"));
    if (response.statusCode == 200) {
      final list = parseModelList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}
