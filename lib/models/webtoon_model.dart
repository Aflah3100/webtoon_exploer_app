class WebtoonModel {
  int? id;
  String? title;
  String? creator;
  String? genre;
  String? image;
  String? description;

  WebtoonModel(
      {this.id,
      this.title,
      this.creator,
      this.genre,
      this.image,
      this.description});

  WebtoonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    creator = json['creator'];
    genre = json['genre'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['creator'] = creator;
    data['genre'] = genre;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
