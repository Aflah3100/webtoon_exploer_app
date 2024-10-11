import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/database/functions/favorites_box/favorites_db.dart';
import 'package:webtoon_explorer_app/database/models/hive_webtoon_model.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/providers/favourite_webtoons_provider.dart';

class WebtoonLikeButton extends StatelessWidget {
  const WebtoonLikeButton({super.key, required this.webtoon});

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteWebtoonsProvider>(
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
                  //Toast-message
                  Fluttertoast.showToast(
                      msg: "Added to favorites",
                      textColor: Colors.white,
                      backgroundColor: Colors.green);
                } else {
                  //Error
                  showErrorToast(message: 'Error adding webtoon to favorites');
                }
              } else {
                //delete-from-hive
                final result = await HiveFavoritesDb.instance
                    .deleteWebtoonFromFavorites(id: webtoon.id!);
                if (result is bool) {
                  //Success-deleting-from-hive
                  provider.deleteWebtoonFromFavoritesList(webtoon.id!);
                } else {
                  showErrorToast(
                      message: 'Error removing webtoon from favorites');
                }
              }
            },
            icon: (Icon((isLiked) ? Icons.favorite : Icons.favorite_outline)));
      },
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
