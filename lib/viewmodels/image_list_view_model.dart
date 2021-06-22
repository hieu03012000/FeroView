import 'package:fero/models/images.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/viewmodels/model_image_view_model.dart';
import 'package:flutter/material.dart';

class ImageListViewModel with ChangeNotifier {
  List<ModelImageViewModel> images = List<ModelImageViewModel>();

  void topHeadlines(String modelId) async {
    List<ModelImage> list = await ImageService().getImageList(modelId);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    this.images =
        list.map((images) => ModelImageViewModel(image: images)).toList();
  }
}
