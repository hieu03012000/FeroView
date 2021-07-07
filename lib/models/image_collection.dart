class ImageCollection {
  final int id;
  final String name;

  ImageCollection({
    this.id,
    this.name
  });

  factory ImageCollection.fromJson(Map<String, dynamic> json) {
    return ImageCollection(
      id: json['id'],
      name: json['name'],
    );
  }
}
