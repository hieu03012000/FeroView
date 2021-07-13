import 'package:fero/models/body-attribute.dart';

class ModelAttributeViewModel {
  BodyAttribite _bodyAttribite;

  ModelAttributeViewModel({BodyAttribite bodyAttribite})
      : _bodyAttribite = bodyAttribite;

  int get id {
    return _bodyAttribite.id;
  }

  double get value {
    return _bodyAttribite.value;
  }

  int get bodyAttTypeId {
    return _bodyAttribite.bodyAttTypeId;
  }

  int get bodyPartId {
    return _bodyAttribite.bodyPartId;
  }

  String get bodyAttName {
    return _bodyAttribite.bodyAttName;
  }

  String get bodyPartName {
    return _bodyAttribite.bodyPartName;
  }

  String get measure {
    return _bodyAttribite.measure;
  }
}
