import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());

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
