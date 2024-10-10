import 'dart:convert';

import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:flutter/services.dart' as the_bundle;
import 'package:webtoon_explorer_app/utils/assets.dart';

class WebtoonApiServices {
  WebtoonApiServices._internal();
  static WebtoonApiServices instance = WebtoonApiServices._internal();
  factory WebtoonApiServices() => instance;

  Future<List<WebtoonModel>> fetchWebtoons() async {
    final data = await the_bundle.rootBundle.loadString(Assets.webtoonsJson);
    final jsonList = jsonDecode(data) as List;

    return jsonList.map((webtoonJson) {
      return WebtoonModel.fromJson(webtoonJson);
    }).toList();
  }
}
