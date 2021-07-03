import 'dart:convert';
import 'dart:io';

import 'package:fero/models/images.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

void uploadFireBase(String path, String modelId) async {
  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(path);

  var snapshot = await _firebaseStorage
      .ref()
      .child('models/' + modelId + "/avatar/images.jpg")
      .putFile(file)
      .onComplete;
  var downloadUrl = await snapshot.ref.getDownloadURL();

  Map<String, dynamic> params = Map<String, dynamic>();
  params['id'] = modelId;
  params['avatar'] = downloadUrl;

  final message = jsonEncode(params);
  final response = await http.put(
      Uri.parse(baseUrl + 'api/v1/models/${params["id"]}/avatar'),
      body: message,
      headers: {"content-type": "application/json"});
  if (response.statusCode == 200) {
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
    modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http
        .get(Uri.parse(baseUrl + "api/v1/models/" + modelId + "/images"));
    if (response.statusCode == 200) {
      var list = parseImageList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future uploadImage(String modelId) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('models/' +
              modelId +
              '/body/M' +
              DateTime.now().toString() +
              '.jpg')
          .putFile(file)
          .onComplete;
      var downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> params = Map<String, dynamic>();
      params['fileName'] = downloadUrl;

      final message = jsonEncode(params);
      final response = await http.post(
          Uri.parse(baseUrl + 'api/v1/models/$modelId/image'),
          body: message,
          headers: {"content-type": "application/json"});
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load');
      }
    }
  }

  Future deleteImage(
      String imageFileUrl, int imageId, String modelId) async {
    var ids = [imageId];

    Map<String, dynamic> params = Map<String, dynamic>();
    params['id'] = ids;
    final message = jsonEncode(params);

    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();

    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/models/${modelId}/image'),
        body: message,
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}
