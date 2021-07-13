class ModelImage {
  final int id;
  final String extension;
  final String fileName;
  final String uploadDate;

  ModelImage({
    this.id,
    this.extension,
    this.uploadDate,
    this.fileName
  });

  factory ModelImage.fromJson(Map<String, dynamic> json) {
    return ModelImage(
      id: json['id'],
      extension: json['extension'],
      uploadDate: json['uploadDate'],
      fileName: json['fileName'],
    );
  }
}
