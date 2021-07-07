import 'package:fero/models/image_collection.dart';

class ImageCollectionViewModel {
  ImageCollection _imageCollection;

  ImageCollectionViewModel({ImageCollection imageCollection}) : _imageCollection = imageCollection;

  int get id {
    return _imageCollection.id;
  }

  String get name {
    return _imageCollection.name;
  }
}
