import 'dart:convert';

import 'package:fero/models/casting.dart';
import 'package:fero/utils/constants.dart';
import 'package:http/http.dart' as http;

class CastingService {
  List<Casting> parseCastingList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Casting>((json) => Casting.fromJson(json)).toList();
  }

  Future<List<Casting>> getCastingList() async {
    final response =
        await http.get(Uri.parse(baseUrl + "api/v1/castings"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}
