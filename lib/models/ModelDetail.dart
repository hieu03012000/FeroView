import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelDetail {
  String name;
  int gender;
  String dateOfBirth;
  String subAddress;
  String phone;
  String gifted;

  ModelDetail({
    this.name,
    this.gender,
    this.dateOfBirth,
    this.subAddress,
    this.phone,
    this.gifted
  });

  //static method
  factory ModelDetail.fromJson(Map<String, dynamic> json) {
    return ModelDetail(
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        subAddress: json["subAddress"],
        phone: json["phone"],
        gifted: json["gifted"]
    );
  }
}

Future<ModelDetail> getModelDetail(String modelId) async {
  final response = await http.get(Uri.parse("https://10.0.2.2:5001/api/v1/models/" + modelId));
  if(response.statusCode == 200) {
    var model = ModelDetail.fromJson(jsonDecode(response.body));
    return model;
  } else {
    throw Exception('Failed to load');
  }
}