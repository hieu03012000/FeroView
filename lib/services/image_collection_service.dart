import 'dart:convert';

import 'package:fero/models/image_collection.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ImageCollectionService {
  List<ImageCollection> parseImageCollectionList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ImageCollection>((json) => ImageCollection.fromJson(json))
        .toList();
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

  Future convertToGif(int castingId) async {
    var images = await ImageService().getImageList(castingId);

    List<Map<String, dynamic>> fileValues = List<Map<String, dynamic>>();
    for (int i = 0; i < images.length; i++) {
      Map<String, dynamic> url = Map<String, dynamic>();
      url['Url'] = images.elementAt(i).fileName;
      fileValues.add(url);
    }
    Map<String, dynamic> urlsEx = Map<String, dynamic>();
    urlsEx['Name'] = 'my_file.jpg';
    urlsEx['Data'] = '<Base64 encoded file content>';
    fileValues.add(urlsEx);

    List<Map<String, dynamic>> parameters = List<Map<String, dynamic>>();
    Map<String, dynamic> files = Map<String, dynamic>();
    files['Name'] = 'Files';
    files['FileValues'] = fileValues;
    parameters.add(files);

    Map<String, dynamic> storeFiles = Map<String, dynamic>();
    storeFiles['Name'] = 'StoreFile';
    storeFiles['Value'] = true;
    parameters.add(storeFiles);

    Map<String, dynamic> parameter = Map<String, dynamic>();
    parameter['Parameters'] = parameters;

    final message = jsonEncode(parameter);

    final response = await http.post(
        Uri.parse('https://v2.convertapi.com/convert/jpg/to/gif?Secret=afGAodLwkQyIPtOQ'),
        body: message,
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}
