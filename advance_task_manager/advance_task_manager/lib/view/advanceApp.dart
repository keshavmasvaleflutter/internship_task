import 'dart:developer';

import 'package:advance_task_manager/model/database.dart';
import 'package:advance_task_manager/controller/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:readmore/readmore.dart';

class AdvanceToDoList extends StatefulWidget {
  const AdvanceToDoList({super.key});

  @override
  State createState() => _AdvanceToDoListState();
}

List<ToDoClass> task = [];
List<dynamic> completeTask = [];
List<dynamic> deleteTask = [];
List<dynamic> paindingTask = [];

List<bool> checkBoxValue = List.filled(task.length, false);

class Modelclass {
  String title;
  String desc;
  String date;
  Modelclass({required this.title, required this.desc, required this.date});
}

class _AdvanceToDoListState extends State {
  bool flag = false;
  int selectedIndex = 0;
  List<Modelclass> data = [
    Modelclass(
        title: "shriram khade", desc: "flutter developer", date: "24 feb 2024")
  ];

  // SlidableController slideControl = SlidableController(AnimationController());

  List<String> information = ["All", "Complete", "Painding", "Delete"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  " Welcome...!",
                  style: GoogleFonts.roboto(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      nameOfUser,
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton.filled(
                      onPressed: () {
                        flag = !flag;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.wb_sunny_sharp,
                        color: flag ? Colors.black : Colors.white,
                      ),
                    ),
                    IconButton.filled(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.logout)),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
          // const SizedBox(
          //   height: 0,
          // ),
          Expanded(
            child: Container(
              // height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: flag
                    ? Colors.black
                    : const Color.fromARGB(255, 245, 244, 244),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "CREATE  Task's",
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: flag
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromARGB(255, 33, 20, 20),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 720,
                    width: double.infinity,
                    // margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: flag
                          ? const Color.fromARGB(255, 12, 7, 7)
                          : const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: SizedBox(
                            height: 45,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: information.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 13,
                                        top: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedIndex = index;
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // height: 30,
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          // top: 5,
                                        ),
                                        // margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: togleColor(index),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0, 1),
                                                  color: flag
                                                      ? const Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                      : Colors.black,
                                                  blurRadius: 10,
                                                  blurStyle: BlurStyle.outer)
                                            ]),
                                        child: Text(
                                          information[index],
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: flag
                                                ? const Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(child: showTaskData()),
                          // child: ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: task.length,
                          //     itemBuilder: ((context, index) {
                          //       return showTaskData(index);
                          //     })),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          returnBottomsheet(true);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color togleColor(index) {
    if (selectedIndex == index) {
      return Colors.green;
    } else {
      return flag ? Colors.black : const Color.fromRGBO(255, 255, 255, 1);
    }
  }

  Widget showTaskData() {
    if (selectedIndex == 2) {
      return pendingTask();
    } else if (selectedIndex == 1) {
      return completeTasks();
    } else if (selectedIndex == 3) {
      return deletedTask();
    } else {
      return allTasks();
    }
  }

  Widget pendingTask() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: paindingTask.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
            decoration: BoxDecoration(
                color: flag
                    ? Colors.black
                    : const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: flag
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : Colors.black,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer)
                ]),
            child: Column(
              children: [
                Container(
                  // height: 90,
                  // width: 400,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    color: flag
                        ? Colors.black
                        : const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Row(
                    children: [
                      Column(children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://banner2.cleanpng.com/20180317/osw/kisspng-task-computer-icons-clip-art-tasks-cliparts-5aad134a5926d3.2654729915212921063652.jpg")),
                            border: Border.all(width: 1),
                            shape: BoxShape.circle,
                            // color: Colors.r,
                            // borderRadius: BorderRadius.circular(70)
                          ),
                        ),
                      ]),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              paindingTask[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: flag
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ReadMoreText(paindingTask[index].desc,
                                    trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      colorClickableText: Colors.blue,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: flag
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 1)
                                              : Colors.black,
                                        ),
                                        moreStyle: const TextStyle(fontSize: 14, color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(paindingTask[index].date,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: flag
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : Colors.black,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        }));
  }

  Widget completeTasks() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: completeTask.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
            decoration: BoxDecoration(
                color: flag
                    ? Colors.black
                    : const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: flag
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : Colors.black,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer)
                ]),
            child: Column(
              children: [
                Container(
                  // height: 90,
                  // width: 400,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    color: flag
                        ? Colors.black
                        : const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Row(
                    children: [
                      Column(children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://banner2.cleanpng.com/20180317/osw/kisspng-task-computer-icons-clip-art-tasks-cliparts-5aad134a5926d3.2654729915212921063652.jpg")),
                            border: Border.all(width: 1),
                            shape: BoxShape.circle,
                            // color: Colors.r,
                            // borderRadius: BorderRadius.circular(70)
                          ),
                        ),
                      ]),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              completeTask[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: flag
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ReadMoreText(completeTask[index].desc,
                                      trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      colorClickableText: Colors.blue,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: flag
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 1)
                                              : Colors.black,
                                        ),
                                        moreStyle: const TextStyle(fontSize: 14, color: Colors.blue),
                                    ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(completeTask[index].date,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: flag
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : Colors.black,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        }));
  }

  Widget deletedTask() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: deleteTask.length,
        itemBuilder: ((context, index) {
          return Slidable(
            // closeOnScroll: false,
            useTextDirection: false,

            endActionPane: ActionPane(
              // dragDismissible: false,
              motion: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      deleteTask.remove(index);
                      setState(() {});
                    },
                    child: Container(
                        height: 90,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.delete)),
                  )
                ],
              ),
              children: const [Icon(Icons.delete)],
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              decoration: BoxDecoration(
                  color: flag
                      ? Colors.black
                      : const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: flag
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : Colors.black,
                        blurRadius: 5,
                        blurStyle: BlurStyle.outer)
                  ]),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: flag
                          ? Colors.black
                          : const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Row(
                      children: [
                        Column(children: [
                          Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://banner2.cleanpng.com/20180317/osw/kisspng-task-computer-icons-clip-art-tasks-cliparts-5aad134a5926d3.2654729915212921063652.jpg")),
                              border: Border.all(width: 1),
                              shape: BoxShape.circle,
                              // color: Colors.r,
                              // borderRadius: BorderRadius.circular(70)
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                deleteTask[index].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: flag
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ReadMoreText(deleteTask[index].desc,
                                      trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      colorClickableText: Colors.blue,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: flag
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 1)
                                              : Colors.black,
                                        ),
                                        moreStyle: const TextStyle(fontSize: 14, color: Colors.blue),
                                      ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(deleteTask[index].date,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: flag
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : Colors.black,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget allTasks() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: task.length,
        itemBuilder: ((context, index) {
          return Slidable(
            // closeOnScroll: false,
            useTextDirection: false,

            endActionPane: ActionPane(
              // dragDismissible: false,
              motion: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      returnBottomsheet(false, task[index]);
                    },
                    child: Container(
                        height: 90,
                        width: 80,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.edit)
                      ),
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteTask.add(task[index]);
                      removeTask(task[index]);
                    },
                    child: Container(
                        height: 90,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.delete)),
                  )
                ],
              ),
              children: const [Icon(Icons.delete)],
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              decoration: BoxDecoration(
                  color: flag
                      ? Colors.black
                      : const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: flag
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : Colors.black,
                        blurRadius: 5,
                        blurStyle: BlurStyle.outer)
                  ]),
              child: Column(
                children: [
                  Container(
                    // height: 90,
                    // width: 400,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: flag
                          ? Colors.black
                          : const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Row(
                      children: [
                        Column(children: [
                          Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://banner2.cleanpng.com/20180317/osw/kisspng-task-computer-icons-clip-art-tasks-cliparts-5aad134a5926d3.2654729915212921063652.jpg")),
                              border: Border.all(width: 1),
                              shape: BoxShape.circle,
                              // color: Colors.r,
                              // borderRadius: BorderRadius.circular(70)
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                task[index].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: flag
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ReadMoreText(task[index].desc,
                                      trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      colorClickableText: Colors.blue,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: ' Show less',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: flag
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 1)
                                              : Colors.black,
                                        ),
                                        moreStyle: const TextStyle(fontSize: 14, color: Colors.blue),
                                      ),
                                  ),
                                  const SizedBox(width: 5,),
                                  // const Spacer(),
                                  Checkbox(
                                      value: checkBoxValue[index],
                                      onChanged: (value) async {
                                        checkBoxValue[index] = value!;
                                        if (checkBoxValue[index] == true) {
                                          completeTask.add(task[index]);
                                          removePainding(task[index]);
                                        }
                                        task = await getToDoClassData();
                                        setState(() {});
                                      }),
                                  const SizedBox(
                                    width: 2,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(task[index].date,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: flag
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : Colors.black,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }));
  }

  void removePainding(ToDoClass obj) {
    paindingTask.remove(obj);
    setState(() {});
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _date = TextEditingController();
  void submitTask() async {
    log("In Submit Function");
    ToDoClass toDoClassObj = ToDoClass(title: _title.text, desc: _desc.text, date: _date.text);
    insertToDoClassData(toDoClassObj);
    paindingTask
        .add(ToDoClass(title: _title.text, desc: _desc.text, date: _date.text));
  }

  void clearController() {
    _title.clear();
    _desc.clear();
    _date.clear();
    popNevigator();
  }

  void popNevigator() async {
    task = await getToDoClassData();
    Navigator.pop(context);
    setState(() {});
  }

  void removeTask(ToDoClass obj) async {
    task.remove(obj);
    await deleteToDoClassData(obj.ind);
    task = await getToDoClassData();
    setState(() {});
  }

  void returnBottomsheet(bool flag, [ToDoClass? obj]) {
    if (flag == false) {
      _title.text = obj!.title;
      _desc.text = obj.desc;
      _date.text = obj.date;
      setState(() {});
    }

    showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 0.8,
        // isScrollControlled: true,
        context: context, //context,
        builder: ((context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CREATE TO DO ",
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text("Title",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                TextFormField(
                  controller: _title,
                  //controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Title",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Description",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                TextFormField(
                  maxLines: 4,
                  controller: _desc,
                  //controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Description",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Date",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                TextField(
                  controller: _date,
                  // readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.date_range_rounded),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025),
                    );
                    String formatedDate =
                        DateFormat.yMMMd().format(pickeddate!);
                    setState(() {
                      _date.text = formatedDate;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (flag == true) {
                            if (_date.text.isNotEmpty &&
                                _desc.text.isNotEmpty &&
                                _title.text.isNotEmpty) {
                              submitTask();
                            }
                          } else {
                            obj = ToDoClass(
                                ind: obj!.ind,
                                title: _title.text,
                                desc: _desc.text,
                                date: _date.text);
                            await updateToDoClassData(obj!);
                            paindingTask.add(obj);
                          }

                          task = await getToDoClassData();
                          checkBoxValue = List.filled(task.length, false);

                          clearController();
                          // ================================= //
                          setState(() {});
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 34, 234, 148)),
                            child: Text("submit",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )))),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
