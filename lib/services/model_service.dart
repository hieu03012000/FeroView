import 'dart:convert';

import 'package:fero/models/model.dart';
import 'package:http/http.dart' as http;

class ModelService {
  Future<Model> getModelDetail(String modelId) async {
    final response = await http
        .get(Uri.parse("https://10.0.2.2:5001/api/v1/models/" + modelId));
    if (response.statusCode == 200) {
      var model = Model.fromJsonDetail(jsonDecode(response.body));
      return model;
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
        await http.get(Uri.parse("https://10.0.2.2:5001/api/v1/models"));
    if (response.statusCode == 200) {
      final list = parseModelList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}
