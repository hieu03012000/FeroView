import 'package:fero/models/model.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/services/model_service.dart';
import 'package:fero/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';

class ModelViewModel with ChangeNotifier {
  Model _model;

  ModelViewModel({Model model}) : _model = model;

  String get id {
    return _model.id;
  }

  set id(String id) {
    this.id = id;
  }

  String get name {
    return _model.name;
  }

  set name(String name) {
    this.name = name;
  }

  String get username {
    return _model.username;
  }

  set username(String username) {
    this.username = username;
  }

  int get gender {
    return _model.gender;
  }

  set gender(int gender) {
    this.gender = gender;
  }

  String get dateOfBirth {
    return _model.dateOfBirth;
  }

  String get age {
    return castAge(_model.dateOfBirth);
  }

  set dateOfBirth(String dateOfBirth) {
    this.dateOfBirth = dateOfBirth;
  }

  String get subAddress {
    return _model.subAddress;
  }

  set subAddress(String subAddress) {
    this.subAddress = subAddress;
  }

  String get phone {
    return _model.phone;
  }

  set phone(String phone) {
    this.phone = phone;
  }

  String get gifted {
    return _model.gifted;
  }

  set gifted(String gifted) {
    this.gifted = gifted;
  }

  String get avatar {
    return _model.avatar;
  }

  set avatar(String avatar) {
    this.avatar = avatar;
  }

  int get status {
    return _model.status;
  }

  set status(int status) {
    this.status = status;
  }
  // List<ModelStyle> get modelStyle {
  //   return _model.modelStyle;
  // }

  Future<ModelViewModel> getModel(String modelId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      Model model = await ModelService().getModelDetail(modelId);
      notifyListeners();
      this._model = model;
    });
  }

  Future<ModelViewModel> updateProfileModel(Map<String, dynamic> params) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      Model model = await ModelService().updateModelDetail(params);
      notifyListeners();
      this._model = model;
    });
  }

   Future<ModelViewModel> updateAvatar(String path, String modelId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      String avt = await uploadFireBase(path, modelId);
      notifyListeners();
      avatar = avt;
    });
  }
}
