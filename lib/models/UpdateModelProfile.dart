import 'dart:async';
import 'dart:convert';
import 'package:fero/models/ModelDetail.dart';
import 'package:http/http.dart' as http;

class UpdateModel {
  String id;
  String name;
  int gender;
  String dateOfBirth;
  String subAddress;
  String phone;
  String gifted;

  UpdateModel({
    this.id,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.subAddress,
    this.phone,
    this.gifted
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      subAddress: json['subAddress'],
      phone: json['phone'],
      gifted: json['gifted']
    );
  }

  factory UpdateModel.fromUpdateModel(ModelDetail another) {
    return UpdateModel(
      id: another.id,
      name: another.name,
      gender: another.gender,
      dateOfBirth: another.dateOfBirth,
      subAddress: another.subAddress,
      phone: another.phone,
      gifted: another.gifted,
    );
  }


}

Future<UpdateModel> updateModelDetail(Map<String, dynamic> params) async {
  final message = jsonEncode(params);
  final response = await
  http.put(Uri.parse('https://10.0.2.2:5001/api/v1/models/${params["id"]}/profile'),
      body: message, headers: {"content-type": "application/json"});
  if(response.statusCode == 200) {
    var responseBody = UpdateModel.fromJson(jsonDecode(response.body));
    return responseBody;
  } else {
    throw Exception('Failed to load');
  }
}