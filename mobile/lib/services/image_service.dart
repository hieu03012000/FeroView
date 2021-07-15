import 'dart:convert';
import 'dart:io';

import 'package:fero/models/image_collection_gif.dart';
import 'package:fero/models/images.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

void uploadFireBase(String path, String modelId) async {
  var token = (await FlutterSession().get("token")).toString();
  Map<String, String> heads = Map<String, String>();
  heads['Content-Type'] = 'application/json';
  heads['Accept'] = 'application/json';
  heads['Authorization'] = 'Bearer $token';
  final _firebaseStorage = FirebaseStorage.instance;

  var file = File(path);

  var snapshot = await _firebaseStorage
      .ref()
      .child('models/' + modelId + "/avatar/images.jpg")
      .putFile(file);
  var downloadUrl = await snapshot.ref.getDownloadURL();

  Map<String, dynamic> params = Map<String, dynamic>();
  params['id'] = modelId;
  params['avatar'] = downloadUrl;

  final message = jsonEncode(params);
  final response = await http.put(
      Uri.parse(baseUrl + 'api/v1/models/${params["id"]}/avatar'),
      body: message,
      headers: heads);
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

  Future<List<ModelImage>> getImageList(int collectionId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final response = await http.get(
        Uri.parse(baseUrl + "api/v1/images/$collectionId"),
        headers: heads);
    if (response.statusCode == 200) {
      var list = parseImageList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future uploadImage(int collectionId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    String modelId = (await FlutterSession().get('modelId')).toString();
    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('models/' +
              modelId +
              '/body/M' +
              DateTime.now().toString() +
              '.jpg')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> params = Map<String, dynamic>();
      params['fileName'] = downloadUrl;

      final message = jsonEncode(params);
      final response = await http.post(
          Uri.parse(baseUrl + 'api/v1/models/$modelId/$collectionId/image'),
          body: message,
          headers: heads);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load');
      }
    }
  }

  Future deleteImage(String imageFileUrl, int imageId) async {
    var ids = [imageId];
    String modelId = (await FlutterSession().get('modelId')).toString();
    Map<String, dynamic> params = Map<String, dynamic>();
    params['id'] = ids;
    final message = jsonEncode(params);

    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';

    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();

    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/models/$modelId/image'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }

  // List<int> generateGIF(Iterable<Image> images) async {
  //   var token = (await FlutterSession().get("token")).toString();
  //   Map<String, String> heads = Map<String, String>();
  //   heads['Content-Type'] = 'application/json';
  //   heads['Accept'] = 'application/json';
  //   heads['Authorization'] = 'Bearer $token';
  // }

  Future<void> saveGif(ImageCollectionGif gif, int collecttionId) async {
    String modelId = (await FlutterSession().get('modelId')).toString();
    // final _firebaseStorage = FirebaseStorage.instance;

    // File('assets/img/${gif.Url}').create();
    // var file = File('assets/img/${gif.Url}');

    // var snapshot = await _firebaseStorage
    //     .ref()
    //     .child('models/' + modelId + "/gif/${gif.FileName}")
    //     .putString(gif.Url);

    // var downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> params = Map<String, dynamic>();
    params['collectionId'] = collecttionId;
    params['gif'] = gif.Url;

    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';

    final message = jsonEncode(params);
    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/collection-images/$modelId/gif'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}
