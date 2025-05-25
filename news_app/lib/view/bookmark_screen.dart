import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/controllers/controllers.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view/view.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final BookmarkController bookmarkController = Get.put(BookmarkController());

    return Obx(() => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 50.h),
                  Text(
                    "Your Saved Articles",
                    style: textTheme.displayLarge,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "All your bookmarked news in one place",
                    style: textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.h),
                ]),
              ),
            ),
            if (bookmarkController.bookmarkedArticles.isEmpty)
              SliverFillRemainingWithEmptyState(textTheme: textTheme)
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final article =
                          bookmarkController.bookmarkedArticles[index];
                      return _buildBookmarkItem(
                          context, article, textTheme, bookmarkController);
                    },
                    childCount: bookmarkController.bookmarkedArticles.length,
                  ),
                ),
              ),
          ],
        ));
  }

  Widget _buildBookmarkItem(BuildContext context, Articles article,
      TextTheme textTheme, BookmarkController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => NewsDescription(article: article));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.urlToImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            article.urlToImage.toString(),
                            height: 120.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 120.h,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      SizedBox(height: 8.h),
                      Text(
                        article.title.toString(),
                        style: textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        article.description ?? "",
                        style: textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.bookmark_remove,
                  color: AppColors.pinkAccent,
                  size: 28.r,
                ),
                onPressed: () {
                  controller.removeBookmark(article);
                  Get.snackbar(
                    "Removed",
                    "Article removed from bookmarks",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.pinkAccent.withOpacity(0.9),
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: AppColors.pinkAccent,
                  ),
                ),
                child: Text(
                  article.source?.name ?? "Unknown Source",
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.pinkAccent,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "• ${DateTime.parse(article.publishedAt ?? DateTime.now().toString())}",
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(),
        ],
      ),
    );
  }
}

class SliverFillRemainingWithEmptyState extends StatelessWidget {
  final TextTheme textTheme;

  const SliverFillRemainingWithEmptyState({
    super.key,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 60.r,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            "No bookmarked articles yet",
            style: textTheme.headlineSmall?.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 8.h),
          Text(
            "Save articles to read them later",
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
