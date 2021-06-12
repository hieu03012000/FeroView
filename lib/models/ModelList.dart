import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelStyle {
  final int styleId;
  final String styleName;

  ModelStyle({
   this.styleId,
    this.styleName
  });

  factory ModelStyle.fromJson(Map<String, dynamic> json) {
    return ModelStyle(
      styleId: json['styleId'],
      styleName: json['styleName']
    );
  }


}

class ModelList {
  final String id;
  final String avatar;
  final String name;
  final int gender;
  final String dateOfBirth;
  final String subAddress;
  final String phone;
  final String gifted;
  final bool status;
  final List<ModelStyle> modelStyle;

  ModelList({
    this.id,
    this.avatar,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.subAddress,
    this.phone,
    this.gifted,
    this.status,
    this.modelStyle
  });

  //static method
  factory ModelList.fromJson(Map<String, dynamic> json) {
    var list = json['modelStyle'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<ModelStyle> styleList = list.map((i) => ModelStyle.fromJson(i)).toList();
    return ModelList(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      subAddress: json['subAddress'],
      phone: json['phone'],
      gifted: json['gifted'],
      status: json['status'],
      modelStyle: styleList
    );
  }
}

List<ModelList> parseModelList(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final list = parsed.map<ModelList>((json) => ModelList.fromJson(json)).toList();
  return list;
}

Future<List<ModelList>> getModelList() async {
  final response = await http.get(Uri.parse("https://10.0.2.2:5001/api/v1/models"));
  if(response.statusCode == 200) {
    var list = parseModelList(response.body);
    return list;
  } else {
    throw Exception('Failed to load');
  }
}

String castGender(int gender) {
  String g;
  if(gender == 0) g = "Male";
  else if (gender == 1) g = "Female";
  else g = "Another";
  return g;
}

String castAge(String date) {
  DateTime dateTime = DateTime.parse(date);
  int age = DateTime.now().year - dateTime.year;
  return age.toString() + ' years old';
}
