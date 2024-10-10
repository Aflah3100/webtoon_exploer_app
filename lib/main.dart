import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/router/generate_route.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webtoon Explorer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade700),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
      home:  HomeScreen(),
    );
  }
}
