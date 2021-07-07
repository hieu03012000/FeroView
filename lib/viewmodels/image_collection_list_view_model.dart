import 'package:fero/models/image_collection.dart';
import 'package:fero/models/images.dart';
import 'package:fero/services/image_collection_service.dart';
import 'package:fero/viewmodels/image_collection_view_model.dart';
import 'package:flutter/material.dart';

class ImageCollectionListViewModel with ChangeNotifier {
  List<ImageCollectionViewModel> imageCollections = List<ImageCollectionViewModel>();

  Future<ImageCollectionListViewModel> getImageCollectionList() async {
    List<ImageCollection> list = await ImageCollectionService().getImageCollectionList();
    notifyListeners();
    this.imageCollections =
        list.map((collections) => ImageCollectionViewModel(imageCollection: collections)).toList();
  }
}
