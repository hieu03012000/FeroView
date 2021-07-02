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

  int get monopolyTime {
    return _casting.monopolyTime;
  }

  String get openTime {
    return _casting.openTime != null ? formatDate(_casting.openTime) : 'null';
  }

  DateTime get openTimeDateTime {
    return parseDatetime(_casting.openTime);
  }

  String get closeTime {
    return _casting.closeTime != null ? formatDate(_casting.closeTime) : 'null';
  }

  DateTime get closeTimeDateTime {
    return parseDatetime(_casting.closeTime);
  }

  int get status {
    return _casting.status;
  }

  String get customerId {
    return _casting.customerId;
  }

  double get salary {
    return _casting.salary;
  }

  String get customerName {
    return _casting.customerName;
  }

  int get brandId {
    return _casting.brandId;
  }
}
