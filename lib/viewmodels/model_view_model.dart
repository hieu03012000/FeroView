import 'package:fero/models/model.dart';
import 'package:fero/services/model_service.dart';
import 'package:flutter/cupertino.dart';

class ModelViewModel with ChangeNotifier {
  Model _model;

  ModelViewModel({Model model}) : _model = model;

  String get id {
    return _model.id;
  }

  String get name {
    return _model.name;
  }

  String get gender {
    return castGender(_model.gender);
  }

  String get dateOfBirth {
    return _model.dateOfBirth;
  }

  String get age {
    return castAge(_model.dateOfBirth);
  }

  String get subAddress {
    return _model.subAddress;
  }

  String get phone {
    return _model.phone;
  }

  String get gifted {
    return _model.gifted;
  }

  String get avatar {
    return _model.avatar;
  }

  bool get status {
    return _model.status;
  }

  // List<ModelStyle> get modelStyle {
  //   return _model.modelStyle;
  // }

  String castGender(int gender) {
    String g;
    if (gender == 0)
      g = "Male";
    else if (gender == 1)
      g = "Female";
    else
      g = "Another";
    return g;
  }

  String castAge(String date) {
    DateTime dateTime = DateTime.parse(date);
    int age = DateTime.now().year - dateTime.year;
    return age.toString() + ' years old';
  }

  void topHeadlines(String modelId) async {
    Model model = await ModelService().getModelDetail(modelId);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
    this._model = model;
  }
}
