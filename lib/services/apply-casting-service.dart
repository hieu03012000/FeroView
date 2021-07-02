import 'dart:convert';

import 'package:fero/utils/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApplyCastingSrevice {
  Future createApplyCasting(int castingId) async {
    var modelId = (await FlutterSession().get("modelId")).toString();

    Map<String, dynamic> params = Map<String, dynamic>();
    params['modelId'] = modelId;
    params['castingId'] = castingId;

    final message = jsonEncode(params);
    final response = await http.put(
      Uri.parse(baseUrl + '/api/v1/apply-castings'),
      body: message,
      headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Apply success');
    } else {
      throw Exception('Failed to load');
    }
  }

  // Future<bool> isApply(int castingId) async {
  //   var modelId = (await FlutterSession().get("modelId")).toString();

  //   Map<String, dynamic> params = Map<String, dynamic>();
  //   params['modelId'] = modelId;
  //   params['castingId'] = castingId;

  //   final message = jsonEncode(params);
  //   final response = await http.put(
  //     Uri.parse(baseUrl + '/api/v1/apply-castings'),
  //     body: message,
  //     headers: {"content-type": "application/json"});
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(msg: 'Apply success');
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }
}
