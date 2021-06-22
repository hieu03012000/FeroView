class Casting {
  final int id;
  final String name;
  final String description;
  final String openTime;
  final String closeTime;
  final int status;

  Casting({
    this.id,
    this.name,
    this.description,
    this.openTime,
    this.closeTime,
    this.status,
  });

  //static method
  factory Casting.fromJson(Map<String, dynamic> json) {
    return Casting(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      status: json['status'],
    );
  }
}
