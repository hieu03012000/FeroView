class BodyPart {
  final int id;
  final String name;

  BodyPart({
    this.id,
    this.name,
  });

  //static method
  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(
      id: json["id"],
      name: json["name"],
    );
  }

}
