import 'package:get/get.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/api_service.dart';

class NewsController extends GetxController {
  NewsModel newsModel = NewsModel();
  final List<Articles> articles = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchNewsArticles();
  }


  Future<void> fetchNewsArticles() async {
    try {
      final data = await NewsService.fetchNewsFromAPI(query: "india");
      newsModel = data;
      articles.assignAll(newsModel.articles ?? []);
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }
}