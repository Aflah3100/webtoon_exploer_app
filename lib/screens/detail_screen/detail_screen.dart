import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detailScreen';
  const DetailScreen({super.key, required this.webtoon});
  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: height * 0.40,
            toolbarHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                webtoon.image ?? "",
                fit: BoxFit.contain,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: width,
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(webtoon.title ?? 'Webtoon',
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.start,
                            style: AppFonts.poppinsTextStyle(
                                fontSize: 25,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    "Creator: ${webtoon.creator ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    "Genre: ${webtoon.genre ?? "Not found"}",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 18,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text(
                    webtoon.description ?? "",
                    style: AppFonts.poppinsTextStyle(
                        fontSize: 15,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w400),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
