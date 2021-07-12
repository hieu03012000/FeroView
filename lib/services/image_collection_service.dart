import 'dart:convert';

import 'package:fero/models/image_collection.dart';
import 'package:fero/models/image_collection_gif.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ImageCollectionService {
  List<ImageCollection> parseImageCollectionList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ImageCollection>((json) => ImageCollection.fromJson(json))
        .toList();
  }

  Future<List<ImageCollection>> getImageCollectionList() async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    String modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/collection-images/$modelId"), headers: heads);
    if (response.statusCode == 200) {
      var list = parseImageCollectionList(response.body);
      return list;
    } else {
      return null;
    }
  }

  Future convertToGif(int collectionId) async {
    var images = await ImageService().getImageList(collectionId);

    List<Map<String, dynamic>> fileValues = List<Map<String, dynamic>>();
    for (int i = 0; i < images.length; i++) {
      Map<String, dynamic> url = Map<String, dynamic>();
      url['Url'] = images.elementAt(i).fileName;
      fileValues.add(url);
    }
    // Map<String, dynamic> urlsEx = Map<String, dynamic>();
    // urlsEx['Name'] = 'F:\\my_file.jpg';
    // urlsEx['Data'] = 'Base64';
    // fileValues.add(urlsEx);

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
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var gif = ImageCollectionGif.fromJson(json);
      await ImageService().saveGif(gif, collectionId);
    } 
    else {
      Fluttertoast.showToast(msg: 'Picturea must same size');
      throw Exception('Failed to load');
    }
  }
}
