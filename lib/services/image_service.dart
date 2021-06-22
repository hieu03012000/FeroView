import 'dart:convert';
import 'dart:io';

import 'package:fero/models/images.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

void uploadFireBase(String path, String modelId) async{
  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(path);

  var snapshot = await _firebaseStorage.ref()
      .child('models/' + modelId + "/avatar/images.jpg")
      .putFile(file).onComplete;
  var downloadUrl = await snapshot.ref.getDownloadURL();

  Map<String, dynamic> params = Map<String, dynamic>();
  params['id'] = modelId;
  params['avatar'] = downloadUrl;

  final message = jsonEncode(params);
  final response = await
  http.put(Uri.parse('https://10.0.2.2:5001/api/v1/models/${params["id"]}/avatar'),
      body: message, headers: {"content-type": "application/json"});
  if(response.statusCode == 200) {
  } else {
    throw Exception('Failed to load');
  }
}


class ImageService {
  List<ModelImage> parseImageList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ModelImage>((json) => ModelImage.fromJson(json)).toList();
  }

  Future<List<ModelImage>> getImageList(String modelId) async {
    final response =
    await http.get(Uri.parse(baseUrl + "api/v1/models/" + modelId + "/images"));
    if (response.statusCode == 200) {
      var list = parseImageList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}