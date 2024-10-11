import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/screens/detail_screen/detail_screen.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class WebtoonImageCard extends StatelessWidget {
  const WebtoonImageCard({
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
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(
                webtoon.image ?? "",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              maxLines: 2,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              webtoon.title ?? "Webtoon",
              style: AppFonts.poppinsTextStyle(
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${webtoon.creator} , #${webtoon.genre}',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: AppFonts.poppinsTextStyle(
                  fontSize: 15,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
