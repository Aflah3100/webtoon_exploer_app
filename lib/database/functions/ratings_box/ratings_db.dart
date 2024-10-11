import 'package:hive_flutter/hive_flutter.dart';

class RatingsDb {
  RatingsDb._internal();
  static RatingsDb instance = RatingsDb._internal();
  factory RatingsDb() => instance;

  static const _boxName = 'rating-box';

  void saveRating({required webToonId, required double rating}) async {
    final box = await Hive.openBox(_boxName);
    box.put(webToonId, rating);
    box.close();
  }

  Future<double?> fetchRating({required webToonId}) async {
    final box = await Hive.openBox(_boxName);
    return box.get(webToonId);
  }

  Future<void> deleteRating({required webToonId}) async {
    final box = await Hive.openBox(_boxName);
    box.delete(webToonId);
  }
}
