import 'dart:convert';

import 'package:fero/models/casting.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CastingService {
  List<Casting> parseCastingList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Casting>((json) => Casting.fromJson(json)).toList();
  }

  Future<List<Casting>> getCastingList() async {
    final response = await http.get(Uri.parse(baseUrl + "api/v1/castings"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> searchCastingList(
      String name, String min, String max) async {
    final response = await http.get(Uri.parse(
        baseUrl + "api/v1/castings/search?name=$name&min=$min&max=$max"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> modelApplyCasting() async {
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response =
        await http.get(Uri.parse(baseUrl + 'api/v1/castings/$modelId/apply'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      Fluttertoast.showToast(msg: 'Not found');
      throw Exception('Failed to load');
    }
  }


  Future<List<Casting>> getIncomingCasting() async {
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response =
        await http.get(Uri.parse(baseUrl + 'api/v1/castings/$modelId/incoming'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      Fluttertoast.showToast(msg: 'Not found');
      throw Exception('Failed to load');
    }
  }

  Future<CastingViewModel> getCasting(String castingId) async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    final response =
        await http.get(Uri.parse(baseUrl + 'api/v1/castings/$castingId'));
    if (response.statusCode == 200) {
      var casting = CastingViewModel(
          casting: Casting.fromJson(jsonDecode(response.body)));
      return casting;
    } else {
      Fluttertoast.showToast(msg: 'Not found');
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> getCastingByIds(List<int> castingIds) async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    Map<String, dynamic> params = Map<String, dynamic>();
    params['castingIds'] = castingIds;

    final message = jsonEncode(params);
    final response = await http.post(Uri.parse(baseUrl + 'api/v1/castings'),
        body: message, headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      Fluttertoast.showToast(msg: 'Not found');
      throw Exception('Failed to load');
    }
  }

  Future startThread() async {
    var modelId = (await FlutterSession().get("modelId")).toString();

    final response =
        await http.get(Uri.parse(baseUrl + 'api/v1/castings/$modelId/thread'));
    if (response.statusCode == 200) {
      // var casting = CastingViewModel(
      //     casting: Casting.fromJson(jsonDecode(response.body)));
      // return casting;
    } else {
      Fluttertoast.showToast(msg: 'Not found');
      throw Exception('Failed to load');
    }
  }

  // Future endThread() async {
  //   final response =
  //       await http.get(Uri.parse(baseUrl + 'api/v1/castings/end-thread'));
  //   if (response.statusCode == 200) {
  //     // var casting = CastingViewModel(
  //     //     casting: Casting.fromJson(jsonDecode(response.body)));
  //     // return casting;
  //   } else {
  //     Fluttertoast.showToast(msg: 'Not found');
  //     throw Exception('Failed to load');
  //   }
  // }
}
