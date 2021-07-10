class ImageCollection {
  final int id;
  final String name;
  final String gif;

  ImageCollection({this.id, this.name, this.gif});

  factory ImageCollection.fromJson(Map<String, dynamic> json) {
    return ImageCollection(
      id: json['id'],
      name: json['name'],
      gif: json['gif']
    );
  }
}
