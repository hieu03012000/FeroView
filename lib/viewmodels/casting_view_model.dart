import 'package:fero/models/casting.dart';
import 'package:fero/utils/common.dart';

class CastingViewModel {
  Casting _casting;

  CastingViewModel({Casting casting}) : _casting = casting;

  int get id {
    return _casting.id;
  }

  String get name {
    return _casting.name;
  }

  String get description {
    return _casting.description;
  }

  String get openTime {
    return _casting.openTime != null ? formatDate(_casting.openTime) : 'null';
  }

  String get closeTime {
    return _casting.closeTime != null ? formatDate(_casting.closeTime) : 'null';
  }

  int get gifted {
    return _casting.status;
  }
}
