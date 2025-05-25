import 'package:get/get.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/api_service.dart';

class NewsController extends GetxController {
  NewsModel newsModel = NewsModel();
  final List<Articles> articles = <Articles>[].obs;
  RxBool isLoading = true.obs;

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
      isLoading.value = false;
      update();
    } catch (error) {
      isLoading.value = false;
      update();
    }
  }
}