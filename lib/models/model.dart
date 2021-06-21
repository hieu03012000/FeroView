import 'package:fero/models/ModelList.dart';

class Model {
  final String id;
  final String name;
  final String username;
  final int gender;
  final String dateOfBirth;
  final String subAddress;
  final String phone;
  final String gifted;
  final String avatar;
  final bool status;
  final List<ModelStyle> modelStyle;

  Model(
      {this.id,
      this.name,
      this.username,
      this.gender,
      this.dateOfBirth,
      this.subAddress,
      this.phone,
      this.avatar,
      this.gifted,
      this.status,
      this.modelStyle});

  //static method
  factory Model.fromJson(Map<String, dynamic> json) {
    var list = json['modelStyle'] as List;
    List<ModelStyle> styleList =
        list.map((i) => ModelStyle.fromJson(i)).toList();
    return Model(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        subAddress: json["subAddress"],
        phone: json["phone"],
        gifted: json["gifted"],
        avatar: json["avatar"],
        status: json['status'],
        modelStyle: styleList);
  }

  factory Model.fromJsonDetail(Map<String, dynamic> json) {
    return Model(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"],
      subAddress: json["subAddress"],
      phone: json["phone"],
      gifted: json["gifted"],
      avatar: json["avatar"],
      status: json['status'],
    );
  }
}
