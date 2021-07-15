import 'dart:convert';

import 'package:fero/models/body_part.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class BodyPartService {
  List<BodyPart> parseBodyPartList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BodyPart>((json) => BodyPart.fromJson(json))
        .toList();
  }

  Future<List<BodyPart>> getBodyPartList() async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    String modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/body-parts/$modelId"), headers: heads);
    if (response.statusCode == 200) {
      var list = parseBodyPartList(response.body);
      return list;
    } else {
      return null;
    }
  }

}
