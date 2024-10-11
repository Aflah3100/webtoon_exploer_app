import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/database/functions/ratings_box/ratings_db.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/router/route_constants.dart';
import 'package:webtoon_explorer_app/screens/home_screen/home_screen.dart';
import 'package:webtoon_explorer_app/screens/home_screen/widgets/webtoon_like_button.dart';
import 'package:webtoon_explorer_app/utils/app_colors.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = RouteConstants.detailScreen;
  const DetailScreen({super.key, required this.webtoon});
  final WebtoonModel webtoon;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _currentRating = 0.0;

  @override
  void initState() {
    RatingsDb.instance
        .fetchRating(webToonId: widget.webtoon.id!)
        .then((rating) {
      if (rating != null) {
        setState(() {
          _currentRating = rating;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: height * 0.40,
            toolbarHeight: 45,
            pinned: true,
            title: const Text(''),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var percentage = (constraints.maxHeight - kToolbarHeight) /
                    (height * 0.40 - kToolbarHeight);
                bool isCollapsed = percentage < 0.2;

                return FlexibleSpaceBar(
                  title: isCollapsed
                      ? Text(
                          widget.webtoon.title ?? 'Webtoon',
                          style: AppFonts.poppinsTextStyle(
                            fontSize: 18,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  centerTitle: true,
                  background: Image.network(
                    widget.webtoon.image ?? "",
                    fit: BoxFit.fill,
                  ),
                  collapseMode: CollapseMode.pin,
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.appYellowColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(widget.webtoon.title ?? 'Webtoon',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: AppFonts.poppinsTextStyle(
                                fontSize: 25,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      //Webtoon-like-button
                      WebtoonLikeButton(webtoon: widget.webtoon)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Creator: ${widget.webtoon.creator ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Genre: ${widget.webtoon.genre ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        "Rating: ",
                        style: AppFonts.poppinsTextStyle(
                            fontSize: 18,
                            fontColor: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      buildRatingBar()
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    " ${widget.webtoon.description}\n${widget.webtoon.description}\n${widget.webtoon.description}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 15,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatingBar() {
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              if (_currentRating == i.toDouble()) {
                setState(() {
                  _currentRating = 0.0;
                  RatingsDb.instance
                      .deleteRating(webToonId: widget.webtoon.id!);
                });
              } else {
                setState(() {
                  _currentRating = i.toDouble();
                  RatingsDb.instance.saveRating(
                      webToonId: widget.webtoon.id!, rating: _currentRating);
                });
              }
            },
            child: Icon(
              i <= _currentRating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 30,
            ),
          ),
      ],
    );
  }
}
