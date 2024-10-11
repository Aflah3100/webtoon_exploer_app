import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/router/route_constants.dart';
import 'package:webtoon_explorer_app/utils/app_colors.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = RouteConstants.detailScreen;
  const DetailScreen({super.key, required this.webtoon});
  final WebtoonModel webtoon;

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
                          webtoon.title ?? 'Webtoon',
                          style: AppFonts.poppinsTextStyle(
                            fontSize: 18,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  centerTitle: true,
                  background: Image.network(
                    webtoon.image ?? "",
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
                        child: Text(webtoon.title ?? 'Webtoon',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: AppFonts.poppinsTextStyle(
                                fontSize: 25,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Creator: ${webtoon.creator ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Genre: ${webtoon.genre ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Rating: ",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    " ${webtoon.description}\n${webtoon.description}\n${webtoon.description}",
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
}
