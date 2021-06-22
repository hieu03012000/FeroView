import 'package:fero/models/images.dart';
import 'package:intl/intl.dart';

class ModelImageViewModel {
  ModelImage _image;

  ModelImageViewModel({ModelImage image}) : _image = image;

  int get id {
    return _image.id;
  }

  String get fileName {
    return _image.fileName;
  }

  String get extension {
    return _image.extension;
  }

  String get uploadDate {
    return _image.uploadDate != null ? formatDate(_image.uploadDate) : 'null';
  }

  String formatDate(String date) {
    DateTime dt = DateTime.parse(date);
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(dt);
  }
}
