class Task {
  final int id;
  final DateTime startAt;
  final DateTime endAt;
  final int castingId;
  final String castingName;
  final String modelId;

  Task(
      {this.id,
      this.startAt,
      this.endAt,
      this.castingId,
      this.castingName,
      this.modelId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        castingId: json['castingId'],
        castingName: json['castingName'],
        endAt: json['endAt'],
        startAt: json['startAt'],
        modelId: json['modelId']);
  }
}
