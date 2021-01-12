class Photo {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  Photo(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      author: json['author'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String,
      downloadUrl: json['downloadUrl'] as String,
    );
  }
}
