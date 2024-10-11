import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/database/functions/favorites_box/favorites_db.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/providers/favourite_webtoons_provider.dart';
import 'package:webtoon_explorer_app/router/route_constants.dart';
import 'package:webtoon_explorer_app/screens/detail_screen/detail_screen.dart';
import 'package:webtoon_explorer_app/screens/favorites_screen/favorites_screen.dart';
import 'package:webtoon_explorer_app/services/webtoon_api_services.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = RouteConstants.homeScreen;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _fetchFavoriteWebtoonsFromHive();
    super.initState();
  }

  void _fetchFavoriteWebtoonsFromHive() async {
    final favoriteWebtoonsProvider = context.read<FavoriteWebtoonsProvider>();
    HiveFavoritesDb.instance.fetchFavoriteWebtoons().then(
      (hiveWebtoonModelList) {
        final webtoonIdList =
            hiveWebtoonModelList.map((element) => element.id).toList();
        favoriteWebtoonsProvider.setFavoritesWebtoonsIdList(webtoonIdList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton.filled(
          color: Colors.yellow.shade100,
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.pushNamed(context, FavoritesScreen.routeName);
          },
        ),
        // backgroundColor: Colors.white,
        title: Text(
          'WebToon Explorer',
          style: AppFonts.poppinsTextStyle(
              fontSize: 22,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          //Base-container
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: WebtoonApiServices.instance.fetchWebtoons(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.yellow.shade700,
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return WebToonDisplayCard(
                              webtoon: snapshot.data![index]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: snapshot.data!.length);
                  }

                  return Center(
                    child: Text(
                      'Error fetching Webtoons!',
                      style: AppFonts.poppinsTextStyle(
                          fontSize: 20,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

class WebToonDisplayCard extends StatelessWidget {
  const WebToonDisplayCard({
    super.key,
    required this.webtoon,
  });
  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: webtoon);
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            children: [
              //Webtoon-image-container
              SizedBox(
                height: 120,
                width: 130,
                child: Image(
                  image: NetworkImage(
                    webtoon.image ?? "",
                  ),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        color: Colors.red,
                        Icons.error,
                        size: 36,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),

              //Webtoon-title
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.center,
                        webtoon.title ?? "Webtoon",
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: AppFonts.poppinsTextStyle(
                            fontSize: 15,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      webtoon.genre ?? "",
                      style: AppFonts.poppinsTextStyle(
                          fontSize: 14,
                          fontColor: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              //like-icon-button
              Consumer<FavoriteWebtoonsProvider>(
                builder: (context, provider, child) {
                  bool isLiked = false;
                  final favouriteWebtoonIds = provider.getFavoritesIdList();

                  for (int i = 0; i < favouriteWebtoonIds.length; i++) {
                    if (favouriteWebtoonIds[i] == webtoon.id!) {
                      isLiked = true;
                      break;
                    }
                  }

                  return IconButton(
                      onPressed: () async {
                        if (!isLiked) {
                          //Add-to-hive
                          final hiveWebtoonModel = HiveWebtoonModel(
                              id: webtoon.id!,
                              title: webtoon.title ?? "Webtoon",
                              creator: webtoon.creator ?? "Not found",
                              genre: webtoon.genre ?? "Not found",
                              image: webtoon.image ?? "",
                              description: webtoon.description ?? "Not found");
                          final result = await HiveFavoritesDb.instance
                              .addToFavourites(webtoonModel: hiveWebtoonModel);
                          if (result is bool) {
                            //Success-in-adding-to-hive
                            provider.addWebtoonToFavoritesList(webtoon.id!);
                          } else {
                            //Error
                            showErrorToast(
                                message: 'Error adding webtoon to favorites');
                          }
                        } else {
                          //delete-from-hive
                          final result = await HiveFavoritesDb.instance
                              .deleteWebtoonFromFavorites(id: webtoon.id!);
                          if (result is bool) {
                            //Success-deleting-from-hive
                            provider
                                .deleteWebtoonFromFavoritesList(webtoon.id!);
                          } else {
                            showErrorToast(
                                message:
                                    'Error removing webtoon from favorites');
                          }
                        }
                      },
                      icon: (Icon((isLiked)
                          ? Icons.favorite
                          : Icons.favorite_outline)));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showErrorToast({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM);
  }
}
