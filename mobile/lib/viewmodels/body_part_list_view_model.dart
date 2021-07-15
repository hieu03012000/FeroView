import 'package:fero/models/body_part.dart';
import 'package:fero/models/image_collection.dart';
import 'package:fero/services/body_part_service.dart';
import 'package:fero/services/image_collection_service.dart';
import 'package:fero/viewmodels/body_part_view_model.dart';
import 'package:flutter/material.dart';

class BodyPartListViewModel with ChangeNotifier {
  List<BodyPartViewModel> bodyParts = List<BodyPartViewModel>();

  Future<BodyPartListViewModel> getBodyPartList() async {
    List<BodyPart> list = await BodyPartService().getBodyPartList();
    notifyListeners();
    this.bodyParts =
        list.map((collections) => BodyPartViewModel(bodyPart: collections)).toList();
  }
}
