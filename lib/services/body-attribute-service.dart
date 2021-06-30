import 'dart:convert';

import 'package:fero/models/body-attribute.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/body-attribut-list-view-model.dart';
import 'package:fero/viewmodels/body-attribute-view-model.dart';
import 'package:http/http.dart' as http;

class ModelAttributeService {
  List<BodyAttribite> parseAttsList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BodyAttribite>((json) => BodyAttribite.fromJson(json)).toList();
  }

   Future<List<BodyAttribite>> getAttsList(String modelId, String type) async {
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/body-attributes/" + modelId + "/" + type));
    if (response.statusCode == 200) {
      var list = parseAttsList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }


  Future updateAttsList(List<Map<String, dynamic>> params) async {
    final message = jsonEncode(params);
    final response = await http
        .put(Uri.parse(baseUrl + "api/v1/body-attributes/update"),
        body: message,
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}