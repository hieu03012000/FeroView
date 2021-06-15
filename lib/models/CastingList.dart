import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CastingList {
  final int id;
  final String name;
  final String description;
  final String openTime;
  final String closeTime;
  final int status;

  CastingList({
    this.id,
    this.name,
    this.description,
    this.openTime,
    this.closeTime,
    this.status,
  });

  //static method
  factory CastingList.fromJson(Map<String, dynamic> json) {
    return CastingList(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      status: json['status'],
    );
  }
}

List<CastingList> parseCastingList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<CastingList>((json) => CastingList.fromJson(json)).toList();
}

Future<List<CastingList>> getCastingList() async {
  final response = await http.get(Uri.parse("https://10.0.2.2:5001/api/v1/castings"));
  if(response.statusCode == 200) {
    var list = parseCastingList(response.body);
    return list;
  } else {
    throw Exception('Failed to load');
  }
}

String formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  var formatter = new DateFormat('dd-MM-yyyy');
  return formatter.format(dt);
}