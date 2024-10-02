import 'database.dart';

class FetchDataModel {
  Data? data;

  FetchDataModel(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = Data(json['data']);
    }
  }
}

class Data {
  int? currentPage;
  int? totalPages;
  List<Events>? events;

  Data(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events!.add(Events(v));
      });
    }
  }
}

class Events {
  String? sId;
  String? description;
  String? title;
  List<String>? images;
  List<String>? comments;
  List<String>? keywords;
  int? likes;

  Events(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    title = json['title'];
    images = List<String>.from(json['images']);
    comments = List<String>.from(json['comments']);
    keywords = List<String>.from(json['keywords']);
    likes = json['likes'];
  }
}

Future<void> insertEventsData(List<Events> events) async {
  for (var event in events) {
    NewsAppData newsData = NewsAppData(
      sId: event.sId,
      title: event.title,
      description: event.description,
      images: event.images,
      comments: event.comments,
      likes: event.likes,
    );
    await insertNewsAppData(newsData);
  }
}