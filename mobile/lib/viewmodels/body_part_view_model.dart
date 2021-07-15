import 'package:fero/models/body_part.dart';
class BodyPartViewModel {
  BodyPart _bodyPart;

  BodyPartViewModel({BodyPart bodyPart}) : _bodyPart = bodyPart;

  int get id {
    return _bodyPart.id;
  }

  String get name {
    return _bodyPart.name;
  }
}
