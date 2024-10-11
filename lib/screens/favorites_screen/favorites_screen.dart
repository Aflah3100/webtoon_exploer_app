import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/database/functions/favorites_box/favorites_db.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/providers/favourite_webtoons_provider.dart';
import 'package:webtoon_explorer_app/router/route_constants.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = RouteConstants.favoritesScreen;
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: AppFonts.poppinsTextStyle(
              fontSize: 22,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: HiveFavoritesDb.instance.fetchFavoriteWebtoons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              //Display-favorite-webtoons
              return Consumer<FavoriteWebtoonsProvider>(
                  builder: (context, notifier, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final hiveWebtoonModel = snapshot.data![index];

                      return (notifier
                              .getFavoritesIdList()
                              .contains(snapshot.data![index].id))
                          ? WebToonDisplayCard(
                              webtoon: WebtoonModel(
                                  id: hiveWebtoonModel.id,
                                  title: hiveWebtoonModel.title,
                                  genre: hiveWebtoonModel.genre,
                                  image: hiveWebtoonModel.image,
                                  description: hiveWebtoonModel.description,
                                  creator: hiveWebtoonModel.creator))
                          : const SizedBox();
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.length);
              });
            } else {
              return Center(
                child: Text(
                  'No Favorite Webtoons Added!',
                  style: AppFonts.poppinsTextStyle(
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          return Center(
            child: Text(
              'No Favorite Webtoons Added!',
              style: AppFonts.poppinsTextStyle(
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      )),
    );
  }
}
