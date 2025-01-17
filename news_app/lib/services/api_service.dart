import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<NewsModel> fetchNewsTrending(
      {String query = "india", String sortBy = "publishedAt"}) async {
    const String apiKey = "eb714cee1349404399bee1937dfd7a9a";
    const String baseUrl = "https://newsapi.org/v2";
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));
    // String typeOfNews = "top-headlines";
    String typeOfNews = "everything";

    final url = Uri.parse(
        "$baseUrl/$typeOfNews?q=$query&from=$todayDate&sortBy=$sortBy&apiKey=$apiKey");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['articles'] != null &&
            (responseData['articles'] as List).isNotEmpty) {
          return NewsModel.fromJson(responseData);
        } else {
          throw Exception("No articles found in the response.");
        }
      } else {
        throw Exception(
            "Failed to fetch news. Status code: ${response.statusCode}");
      }
    } catch (error) {
      log("Error fetching news: $error");
      rethrow;
    }
  }

  // static Future<NewsModel> fetchAllNews(
  //     {String query = "india", String sortBy = "publishedAt"}) async {
  //   String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   log("Date:- $todayDate");

  //   final url = Uri.parse("https://newsapi.org/v2/everything?q=$query&from=$todayDate&sortBy=publishedAt&apiKey=eb714cee1349404399bee1937dfd7a9a");

  //   try {
  //     final response = await http.get(url);
  //     log("Request URL: $url");

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);

  //       log("Response Body: ${response.body}");

  //       if (responseData['articles'] != null &&
  //           (responseData['articles'] as List).isNotEmpty) {
  //         return NewsModel.fromJson(responseData);
  //       } else {
  //         throw Exception("No articles found in the response.");
  //       }
  //     } else {
  //       throw Exception(
  //           "Failed to fetch news. Status code: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     log("Error fetching news: $error");
  //     rethrow;
  //   }
  // }
}
