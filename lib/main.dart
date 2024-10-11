import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';
import 'package:webtoon_explorer_app/providers/favourite_webtoons_provider.dart';
import 'package:webtoon_explorer_app/router/generate_route.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HiveWebtoonModelAdapter().typeId)) {
    Hive.registerAdapter(HiveWebtoonModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteWebtoonsProvider())
      ],
      child: MaterialApp(
        title: 'Webtoon Explorer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade600),
          useMaterial3: true,
        ),
        onGenerateRoute: generateRoute,
        home: HomeScreen(),
      ),
    );
  }
}
