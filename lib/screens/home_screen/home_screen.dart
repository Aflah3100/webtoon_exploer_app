import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/webtoon_model.dart';
import 'package:webtoon_explorer_app/router/route_constants.dart';
import 'package:webtoon_explorer_app/services/webtoon_api_services.dart';
import 'package:webtoon_explorer_app/utils/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = RouteConstants.homeScreen;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
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
    return Card(
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
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //trailing-icon
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_outline))
          ],
        ),
      ),
    );
  }
}
