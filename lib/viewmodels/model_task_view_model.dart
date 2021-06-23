import 'package:fero/models/task.dart';

class ModelTaskViewModel {
  Task _task;

  ModelTaskViewModel({Task task}) : _task = task;

  int get id {
    return _task.id;
  }

  DateTime get startAt {
    return _task.startAt;
  }

  DateTime get endAt {
    return _task.endAt;
  }

  int get castingId {
    return _task.castingId;
  }

  String get castingName {
    return _task.castingName;
  }

  String get modelId {
    return _task.modelId;
  }
}
