class ModelStyle {
  final int styleId;
  final String styleName;

  ModelStyle({this.styleId, this.styleName});

  factory ModelStyle.fromJson(Map<String, dynamic> json) {
    return ModelStyle(styleId: json['styleId'], styleName: json['styleName']);
  }
}
