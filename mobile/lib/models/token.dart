class Token {
  final String token;
  final String mail;

  Token({
    this.token,
    this.mail,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token'], mail: json['mail']);
  }
}
