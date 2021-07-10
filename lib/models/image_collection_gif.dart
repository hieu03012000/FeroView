class ImageCollectionGif {
  final String FileName;
  final String Url;

  ImageCollectionGif({
    this.FileName,
    this.Url
  });

  factory ImageCollectionGif.fromJson(Map<String, dynamic> json) {
    return ImageCollectionGif(
      FileName: json['Files'][0]['FileName'],
      Url: json['Files'][0]['Url'],
    );
  }
}
