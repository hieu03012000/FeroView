import 'package:fero/models/body-attribute.dart';
import 'package:fero/services/body-attribute-service.dart';
import 'package:fero/viewmodels/body-attribute-view-model.dart';
import 'package:flutter/material.dart';

class BodyAttributeListViewModel with ChangeNotifier {
  List<ModelAttributeViewModel> atts = List<ModelAttributeViewModel>();

  Future<BodyAttributeListViewModel> getAttList(String modelId, String type) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      type = type.toLowerCase();
      List<BodyAttribite> list = await ModelAttributeService().getAttsList(modelId, type);
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
