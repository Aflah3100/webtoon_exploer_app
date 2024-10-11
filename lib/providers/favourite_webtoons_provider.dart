import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/database/functions/favorites_box/favorites_db.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';

class FavoriteWebtoonsProvider with ChangeNotifier {
  final List<int> _favoritesWebtoonsIdList = [];

  void addWebtoonToFavoritesList(int id) {
    _favoritesWebtoonsIdList.add(id);
    notifyListeners();
  }

  void setFavoritesWebtoonsIdList(List<int> webtoonId) {
    _favoritesWebtoonsIdList.clear();
    _favoritesWebtoonsIdList.addAll(webtoonId);
    notifyListeners();
  }

  void deleteWebtoonFromFavoritesList(int webtoonId) {
    _favoritesWebtoonsIdList.removeWhere((id) => id == webtoonId);
    notifyListeners();
  }

  List<int> getFavoritesIdList() => _favoritesWebtoonsIdList;
}
