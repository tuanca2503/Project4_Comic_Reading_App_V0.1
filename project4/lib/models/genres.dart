class Genres {
  String id;
  String genresName;
  String? genresImage;

  Genres.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        genresName = json['genresName'],
        genresImage = json['genresImage'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Genres && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}