import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/screens/detail_screen/detail_screen.dart';
import 'package:webtoon_explorer_app/screens/favorites_screen/favorites_screen.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case DetailScreen.routeName:
      final webtoon = routeSettings.arguments as WebtoonModel;
      return MaterialPageRoute(builder: (_) => DetailScreen(webtoon: webtoon));
    case FavoritesScreen.routeName:
      return MaterialPageRoute(builder: (_) => FavoritesScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text(
                    'Screen Does not exist!',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ));
  }
}
