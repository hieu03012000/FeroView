class Casting {
  final int id;
  final String name;
  final String description;
  final int monopolyTime;
  final String openTime;
  final String closeTime;
  final int status;
  final String customerId;
  final int brandId;
  final double salary;
  final String customerName;
  final String incomingTask;

  Casting({
    this.id,
    this.name,
    this.description,
    this.monopolyTime,
    this.openTime,
    this.closeTime,
    this.status,
    this.customerId,
    this.brandId,
    this.salary,
    this.customerName,
    this.incomingTask
  });

  //static method
  factory Casting.fromJson(Map<String, dynamic> json) {
    return Casting(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      monopolyTime: json['monopolyTime'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      status: json['status'],
      customerId: json['customerId'],
      brandId: json['brandId'],
      salary: json['salary'],
      customerName: json['customerName'],
      incomingTask: json['incomingTask']
    );
  }
}
