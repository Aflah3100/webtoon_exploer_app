import 'package:hive_flutter/hive_flutter.dart';
part 'hive_webtoon_model.g.dart';


@HiveType(typeId: 0)
class HiveWebtoonModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String creator;
  @HiveField(4)
  final String genre;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final String description;

  HiveWebtoonModel(
      {required this.id,
      required this.title,
      required this.creator,
      required this.genre,
      required this.image,
      required this.description});
}
