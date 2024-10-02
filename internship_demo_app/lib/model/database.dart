import 'dart:convert';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database>? database;

class NewsAppData {
  String? sId;
  String? description;
  String? title;
  List<String>? images;
  List<String>? comments;
  int? likes;

  NewsAppData({
    required this.sId,
    required this.description,
    required this.title,
    required this.images,
    required this.comments,
    required this.likes,
  });

  Map<String, dynamic> newsAppMap() {
    return {
      'sId': sId,
      'title': title,
      'description': description,
      'images': jsonEncode(images),
      'comments': jsonEncode(comments),
      'likes': likes,
    };
  }

  factory NewsAppData.fromMap(Map<String, dynamic> map) {
    return NewsAppData(
      sId: map['sId'],
      title: map['title'],
      description: map['description'],
      images: List<String>.from(jsonDecode(map['images'])),
      comments: List<String>.from(jsonDecode(map['comments'])),
      likes: map['likes'],
    );
  }

  @override
  String toString() {
    return "{ sId: $sId, title: $title, description: $description, images: $images, comments: $comments, likes: $likes }";
  }
}

Future<void> initDatabase() async {
  database = openDatabase(
    join(await getDatabasesPath(), 'news_app.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE NewsAppData(
            sId TEXT PRIMARY KEY, 
            title TEXT, 
            description TEXT, 
            images TEXT, 
            comments TEXT, 
            likes INTEGER
          )''');
      log('Database and table created');
    },
  );
}

Future<void> insertNewsAppData(NewsAppData obj) async {
  final localDB = await database;

  await localDB!.insert(
    "NewsAppData",
    obj.newsAppMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  log("NewsAppData inserted");
}

Future<List<NewsAppData>> getNewsAppData() async {
  final localDB = await database;
  log("Fetching NewsAppData from SQLite");

  final List<Map<String, dynamic>> newsAppMap =
      await localDB!.query("NewsAppData");

  return List.generate(newsAppMap.length, (i) {
    return NewsAppData.fromMap(newsAppMap[i]);
  });
}
