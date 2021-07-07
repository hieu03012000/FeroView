import 'dart:convert';

import 'package:fero/models/image_collection.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ImageCollectionService {
  List<ImageCollection> parseImageCollectionList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ImageCollection>((json) => ImageCollection.fromJson(json)).toList();
  }

  Future<List<ImageCollection>> getImageCollectionList() async {
    String modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/collection-images/$modelId"));
    if (response.statusCode == 200) {
      var list = parseImageCollectionList(response.body);
      return list;
    } else {
      return null;
    }
  }
}
