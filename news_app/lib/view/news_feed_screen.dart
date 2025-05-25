import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/controllers/controllers.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view/view.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final NewsController newsController = Get.put(NewsController());
    return Obx(
      () => newsController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryLight,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeaderSection(textTheme),
                      _buildTrendingHeader(textTheme),
                    ]),
                  ),
                ),
                if (newsController.articles.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "News Not Available",
                        style: textTheme.headlineMedium,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final article = newsController.articles[index];
                          return _buildNewsItem(context, article, textTheme);
                        },
                        childCount: newsController.articles.length,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

Widget _buildHeaderSection(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 50.h),
      Text(
        "Welcome Back!",
        style: textTheme.displayLarge,
      ),
      SizedBox(height: 8.h),
      Text(
        "Discover a world of news that matters to you",
        style: textTheme.bodyLarge,
      ),
      SizedBox(height: 16.h),
    ],
  );
}

Widget _buildTrendingHeader(TextTheme textTheme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Trending News",
        style: textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
        ),
      ),
      Text(
        "See all",
        style: textTheme.titleMedium,
      ),
    ],
  );
}

Widget _buildNewsItem(
    BuildContext context, Articles article, TextTheme textTheme) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.h),
    child: GestureDetector(
      onTap: () {
        Get.to(() => NewsDescription(article: article));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              article.urlToImage.toString(),
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200.h,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            article.title.toString(),
            style: textTheme.headlineMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
              const Spacer(),
              Expanded(
                child: Text(
                  article.author ?? "Unknown Author",
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.pinkAccent,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    ),
  );
}
