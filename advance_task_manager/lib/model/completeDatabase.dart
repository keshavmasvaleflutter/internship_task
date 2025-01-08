import 'package:advance_task_manager/model/database.dart';
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

// dynamic database;

Future<void> insertCompleteData(ToDoClass obj) async {
  final localDB = await database;
  await localDB.insert("DataComplete", obj.toDoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<ToDoClass>> getCompleteData() async {
  final localDB = await database;
  List<Map<String, dynamic>> data = await localDB.query("DataComplete");
  return List.generate(
    data.length,
    (inde) => ToDoClass(
        ind: data[inde]["ind"],
        title: data[inde]["title"],
        desc: data[inde]["desc"],
        date: data[inde]["date"]),
  );
}

Future<void> updateCompleteData(ToDoClass obj) async {
  final localDB = await database;
  await localDB.update("DataComplete", obj.toDoMap(),
      where: "ind=?", whereArgs: [obj.ind]);
}

Future<void> deleteCompleteData(int? ind) async {
  final localDB = await database;
  await localDB.delete("DataComplete", where: "ind=?", whereArgs: [ind]);
}


//==========================================================

