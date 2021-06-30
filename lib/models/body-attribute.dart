class BodyAttribite {
  final int id;
  final double value;
  final int bodyAttTypeId;
  final int bodyPartId;
  final String bodyAttName;
  final String bodyPartName;
  final String measure;

  BodyAttribite({
    this.id,
    this.value,
    this.bodyAttTypeId,
    this.bodyPartId,
    this.bodyAttName,
    this.bodyPartName,
    this.measure,
  });

  //static method
  factory BodyAttribite.fromJson(Map<String, dynamic> json) {
    return BodyAttribite(
      id: json["id"],
      value: json["value"],
      bodyAttTypeId: json["bodyAttTypeId"],
      bodyPartId: json["bodyPartId"],
      bodyAttName: json["bodyAttName"],
      bodyPartName: json["bodyPartName"],
      measure: json["measure"],
    );
  }

  factory BodyAttribite.fromJsonDetail(Map<String, dynamic> json) {
    return BodyAttribite(
      id: json["id"],
      value: json["value"],
      bodyAttTypeId: json["bodyAttTypeId"],
      bodyPartId: json["bodyPartId"],
      bodyAttName: json["bodyAttName"],
      measure: json["measure"],
    );
  }
}
