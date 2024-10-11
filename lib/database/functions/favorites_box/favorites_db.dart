import 'package:hive_flutter/hive_flutter.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';

class HiveFavoritesDb {
  HiveFavoritesDb._internal();
  static HiveFavoritesDb instance = HiveFavoritesDb._internal();
  factory HiveFavoritesDb() => instance;

  static const _boxName = 'favorites-box';

  //Add-webtoon-to-database
  Future<dynamic> addToFavourites(
      {required HiveWebtoonModel webtoonModel}) async {
    try {
      Box<HiveWebtoonModel> box =
          await Hive.openBox<HiveWebtoonModel>(_boxName);
      box.put(webtoonModel.id, webtoonModel);
      box.close();
      return true;
    } catch (e) {
      return e;
    }
  }

  //Fetch-favorites-database
  Future<List<HiveWebtoonModel>> fetchFavoriteWebtoons() async {
    Box<HiveWebtoonModel> box = await Hive.openBox<HiveWebtoonModel>(_boxName);
    final hivewebtoonsList = box.values.toList();
    box.close();
    return hivewebtoonsList;
  }

  //Delete-webtoon-from-favorites
  Future<dynamic> deleteWebtoonFromFavorites({required int id}) async {
    try {
      Box<HiveWebtoonModel> box =
          await Hive.openBox<HiveWebtoonModel>(_boxName);

      box.delete(id);
      box.close();

      return true;
    } catch (e) {
      return e;
    }
  }

  //Delete-Favorites-database
  Future<dynamic> clearFavorites() async {
    try {
      Box<HiveWebtoonModel> box =
          await Hive.openBox<HiveWebtoonModel>(_boxName);

      box.clear();

      box.close();

      return true;
    } catch (e) {
      return e;
    }
  }
}
