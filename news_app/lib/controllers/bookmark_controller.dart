import 'package:get/get.dart';
import 'package:news_app/model/news_model.dart';

class BookmarkController extends GetxController {
  final RxList<Articles> _bookmarkedArticles = <Articles>[].obs;

  List<Articles> get bookmarkedArticles => _bookmarkedArticles;

  void addBookmark(Articles article) {
    if (!_bookmarkedArticles.contains(article)) {
      _bookmarkedArticles.add(article);
    }
  }

  void removeBookmark(Articles article) {
    _bookmarkedArticles.remove(article);
  }

  bool isBookmarked(Articles article) {
    return _bookmarkedArticles.contains(article);
  }
}