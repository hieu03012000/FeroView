import 'dart:convert';

import 'package:fero/models/body-attribute.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ModelAttributeService {
  List<BodyAttribite> parseAttsList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BodyAttribite>((json) => BodyAttribite.fromJson(json)).toList();
  }

   Future<List<BodyAttribite>> getAttsList(String modelId, String type) async {
     var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/body-attributes/" + modelId + "/" + type), headers: heads);
    if (response.statusCode == 200) {
      var list = parseAttsList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }


  Future updateAttsList(List<Map<String, dynamic>> params) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final message = jsonEncode(params);
    final response = await http
        .put(Uri.parse(baseUrl + "api/v1/body-attributes/update"),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}