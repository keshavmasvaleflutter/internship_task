import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/controllers/controllers.dart';
import 'package:news_app/model/news_model.dart';

class NewsDescription extends StatefulWidget {
  final Articles article;
  const NewsDescription({super.key, required this.article});

  @override
  State createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: newsDescriptionFun(context, widget.article),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement sharing logic here
        },
        backgroundColor: AppColors.grey.withAlpha(50),
        child: const Icon(
          Icons.share,
          color: AppColors.pinkAccent,
        ),
      ),
    );
  }
}

Widget newsDescriptionFun(BuildContext context, Articles article) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  final bookmarkController = Get.put(BookmarkController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          Image.network(
            article.urlToImage ?? '',
            height: MediaQuery.sizeOf(context).height * 0.35,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.055,
            left: MediaQuery.sizeOf(context).width * 0.04,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(AppColors.black.withOpacity(0.4)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppColors.pinkAccent, width: 1),
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_back),
              color: AppColors.pinkAccent,
              iconSize: 26,
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.055,
            right: MediaQuery.sizeOf(context).width * 0.04,
            child: IconButton(
              icon: Icon(
                bookmarkController.isBookmarked(article)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: AppColors.pinkAccent,
                size: 28,
              ),
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(AppColors.black.withOpacity(0.4)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppColors.pinkAccent, width: 1),
                  ),
                ),
              ),
              onPressed: () {
                if (bookmarkController.isBookmarked(article)) {
                  bookmarkController.removeBookmark(article);
                  Get.snackbar(
                    "Removed",
                    "Article removed from bookmarks",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.pinkAccent.withAlpha(200),
                    colorText: Colors.white,
                  );
                } else {
                  bookmarkController.addBookmark(article);
                  Get.snackbar(
                    "Saved",
                    "Article added to bookmarks",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.pinkAccent.withAlpha(200),
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.035),
        child: Text(
          article.title ?? 'No Title',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.03,
            width: MediaQuery.sizeOf(context).width * 0.25,
            margin:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.035),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 1,
                color: Colors.pink,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(left: screenWidth*0.015, top: screenHeight*0.001),
              child: Text(
                article.content.toString(),
                style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.035),
            child: Text(
              article.publishedAt != null
              ? article.publishedAt!.substring(0, 10)
              : 'No Date',
              style: const TextStyle(),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.035,
          vertical: MediaQuery.sizeOf(context).height * 0.015,
        ),
        child: Text(
          article.description ?? 'No Description',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.1,
          vertical: MediaQuery.sizeOf(context).height * 0.0,
        ),
        child: Text(
          "Paid Plan Required for More Content...!!",
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ],
  );
}
