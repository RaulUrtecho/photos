class Photo {
  final int id;
  final String title;
  final String url;

  const Photo({required this.id, required this.title, required this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(id: json['id'], title: json['title'], url: json['url']);
  }
}
