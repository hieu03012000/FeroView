import 'package:fero/models/body-attribute.dart';
import 'package:fero/services/body_attribute_service.dart';
import 'package:fero/viewmodels/body_attribute_view_model.dart';
import 'package:flutter/material.dart';

class BodyAttributeListViewModel with ChangeNotifier {
  List<ModelAttributeViewModel> atts = List<ModelAttributeViewModel>();

  Future<BodyAttributeListViewModel> getAttList(int bodyPartId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<BodyAttribite> list = await ModelAttributeService().getAttsList(bodyPartId);
      notifyListeners();
      this.atts = list.map((att) => ModelAttributeViewModel(bodyAttribite: att)).toList();
    });
  }

  Future<BodyAttributeListViewModel> updateAtt(List<Map<String, dynamic>> params) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      await ModelAttributeService().updateAttsList(params);
      notifyListeners();
    });
  }
}
