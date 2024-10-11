import 'package:hive_flutter/hive_flutter.dart';

class HiveRatingsDb {
  HiveRatingsDb._internal();
  static HiveRatingsDb instance = HiveRatingsDb._internal();
  factory HiveRatingsDb() => instance;

  static const _boxName = 'rating-box';

  void saveRating({required webToonId, required double rating}) async {
    final box = await Hive.openBox(_boxName);
    box.put(webToonId, rating);
    box.close();
  }

  Future<double?> fetchRating({required webToonId}) async {
    final box = await Hive.openBox(_boxName);
    final rating = box.get(webToonId);
    box.close();
    return rating;
  }

  Future<void> deleteRating({required webToonId}) async {
    final box = await Hive.openBox(_boxName);
    box.delete(webToonId);
    box.close();
  }
}
