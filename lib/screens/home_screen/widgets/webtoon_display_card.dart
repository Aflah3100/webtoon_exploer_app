// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/database/functions/favorites_box/favorites_db.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/providers/favourite_webtoons_provider.dart';
import 'package:webtoon_explorer_app/screens/detail_screen/detail_screen.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';
import 'package:webtoon_explorer_app/screens/home_screen/widgets/webtoon_like_button.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class WebToonDisplayCard extends StatelessWidget {
  const WebToonDisplayCard(
      {super.key, required this.webtoon, this.hideLikeButton = false});
  final WebtoonModel webtoon;
  final bool hideLikeButton;

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
              (!hideLikeButton)
                  ? WebtoonLikeButton(webtoon: webtoon)
                  : PopupMenuButton<int>(
                      color: Colors.white,
                      onSelected: (value) async {
                        if (value == 0) {
                          //Remove-from-favorites
                          final result = await HiveFavoritesDb.instance
                              .deleteWebtoonFromFavorites(id: webtoon.id!);
                          if (result is bool) {
                            //Success-deleting-from-hive
                            context
                                .read<FavoriteWebtoonsProvider>()
                                .deleteWebtoonFromFavoritesList(webtoon.id!);
                            Fluttertoast.showToast(
                                msg: "Removed from favorites");
                          } else {
                            showErrorToast(
                                message:
                                    'Error removing webtoon from favorites');
                          }
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              value: 0,
                              child: Center(
                                child: Text(
                                  'Remove from favorites',
                                  style: AppFonts.poppinsTextStyle(
                                      fontSize: 13,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ];
                      },
                    ),
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