class LoginModel {
  final String id;
  final String name;
  final int status;

  LoginModel({
    this.id,
    this.name,
    this.status
  });

  //static method
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json["id"],
      name: json["name"],
      status: json["status"]
    );
  }

}
