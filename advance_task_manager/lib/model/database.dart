import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class ToDoClass {
  int? ind;
  String title;
  String desc;
  String date;

  ToDoClass(
      {this.ind, required this.title, required this.desc, required this.date});

  Map<String, dynamic> toDoMap() {
    return {"ind": ind, "title": title, "desc": desc, "date": date};
  }

  @override
  String toString() {
    return "{ ind:$ind title: $title , desc : $desc , date: $date }";
  }
}

dynamic database;

Future<void> insertToDoClassData(ToDoClass obj) async {
  final localDB = await database;
  await localDB.insert("ToDodata", obj.toDoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
      log("In insertFunction Task Add zala");
}
Future<List<ToDoClass>> getToDoClassData() async {
  final localDB = await database;
  List<Map<String, dynamic>> data = await localDB.query("ToDoData");
  return List.generate(
    data.length,
    (index) => ToDoClass(
        ind: data[index]["ind"],
        title: data[index]["title"],
        desc: data[index]["desc"],
        date: data[index]["date"]),
  );
}

Future<void> updateToDoClassData(ToDoClass obj) async {
  final localDB = await database;
  await localDB
      .update("ToDodata", obj.toDoMap(), where: "ind=?", whereArgs: [obj.ind]);
}

Future<void> deleteToDoClassData(int? ind) async {
  final localDB = await database;
  await localDB.delete("ToDoData", where: "ind=?", whereArgs: [ind]);
}


//==========================================================