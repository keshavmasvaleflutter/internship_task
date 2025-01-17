import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/view/news_description.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsModel newsModel = NewsModel();
  List<Articles>? articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticlesTrending();
  }

  Future<void> fetchArticlesTrending() async {
    try {
      final data = await NewsService.fetchNewsTrending(query: "india");
      setState(() {
        newsModel = data;
        articles = newsModel.articles;
        isLoading = false;
      });
    } catch (error) {
      log("Error fetching articles: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.sizeOf(context).height;
    var screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.035, top: screenHeight * 0.055),
              child: const Text(
                // "Welcome back, Keshav!",
                "Welcome Back !",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.035, top: screenHeight * 0.002),
              child: const Text(
                "Discover a world of news that matters to you",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.035),
                  child: const Text(
                    "Trending News",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.5),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
              height: screenHeight * 0.9,
              child: _trendingNews(context),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: screenWidth * 0.035,
            //       bottom: screenHeight * 0.0001,
            //       top: screenHeight * 0.01),
            //   child: const Text(
            //     "Recommended news",
            //     style: TextStyle(
            //       fontSize: 19,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.00),
            // Column(
            //   children: [
            //     _recommendedNewsContainer(context),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _trendingNews(BuildContext context) {
    var screenHeight = MediaQuery.sizeOf(context).height;
    var screenWidth = MediaQuery.sizeOf(context).width;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }

    if (articles == null || articles!.isEmpty) {
      return Padding(
        padding: EdgeInsets.fromLTRB(screenWidth*0.25,screenHeight*0.25,0,0),
        child: const Text("No Trending News Available",style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),),
      );
    }
    return ListView.builder(
      itemCount: articles!.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final article = articles![index];
        return Container(
          width: screenWidth * 0.57,
          margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.016),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const NewsDescription());
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    article.urlToImage.toString(),
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.005),
                  child: Text(
                    article.title.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    maxLines: 4,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: screenHeight * 0.03,
                      width: screenWidth * 0.22,
                      padding: EdgeInsets.only(left: screenWidth * 0.015),
                      margin: EdgeInsets.only(left: screenWidth * 0.02, top: screenHeight*0.01, bottom: screenHeight*0.01, right: screenWidth*0.4),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.pink,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          article.content.toString(),
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        article.author.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          // color: Colors.pink,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _recommendedNewsContainer(BuildContext context) {
  //   var screenHeight = MediaQuery.sizeOf(context).height;
  //   var screenWidth = MediaQuery.sizeOf(context).width;

  //   if (isLoading) {
  //     return const Center(child: CircularProgressIndicator());
  //   }

  //   if (articles == null || articles!.isEmpty) {
  //     return Container(
  //       padding: EdgeInsets.all(screenHeight*0.04),
  //       child: const Text("No recommended news available")
  //     );
  //   }
  //   return SizedBox(
  //     height: screenHeight*0.04,
  //     child: ListView.builder(
  //       itemCount: articles!.length,
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (context, index) {
  //         final article = articles![index];
      
  //         return Container(
  //           margin: EdgeInsets.only(
  //               bottom: screenHeight * 0.005,
  //               left: screenWidth * 0.035,
  //               right: screenWidth * 0.035),
  //           height: screenHeight * 0.31,
  //           width: double.infinity,
  //           child: GestureDetector(
  //             onTap: () {
  //               Get.to(() => const NewsDescription());
  //             },
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                       top: screenHeight * 0.004, bottom: screenHeight * 0.004),
  //                   child: Text(
  //                     article.title.toString(),
  //                     style: const TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //                 Row(
  //                   children: [
  //                     Container(
  //                       height: screenHeight * 0.03,
  //                       width: screenWidth * 0.2,
  //                       margin: EdgeInsets.only(bottom: screenHeight * 0.01),
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.rectangle,
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: Border.all(
  //                           width: 1,
  //                           color: Colors.pink,
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           article.content.toString(),
  //                           style: const TextStyle(
  //                             color: Colors.pink,
  //                             fontSize: 13,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 ClipRRect(
  //                   borderRadius: const BorderRadius.all(Radius.circular(12)),
  //                   child: article.urlToImage != null
  //                       ? Image.network(
  //                           article.urlToImage.toString(),
  //                           height: screenHeight * 0.19,
  //                           width: double.infinity,
  //                           fit: BoxFit.cover,
  //                         )
  //                       : SizedBox(
  //                           height: screenHeight * 0.19),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

}
