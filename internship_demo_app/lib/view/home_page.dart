import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_demo_app/view/navigaton_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isExpanded = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  int scrollLimit = 2000;
  int lengthLimit = 7;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > scrollLimit) {
        callTofetchNewsData(1);
        if (newsData!.length > lengthLimit) {
          scrollLimit += 2000;
          lengthLimit += 7;
          isExpanded.addAll([
            false,
            false,
            false,
            false,
            false,
            false,
            false,
          ]);
          setState(() {
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.002,
          color: const Color.fromRGBO(198, 196, 196, 1),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.015,
                  top: MediaQuery.of(context).size.width * 0.03,
                ),
                height: 44,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search messages",
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(153, 162, 173, 1),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(235, 242, 250, 1),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color.fromRGBO(153, 162, 173, 1)),
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.015,
                  top: MediaQuery.of(context).size.height * 0.015),
              child: Image.asset("assets/images/filter_24.png"),
            ),
          ],
        ),
        Container(
          height: 7,
          color: const Color.fromRGBO(198, 196, 196, 1),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 248,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: newsData!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final event = newsData![index];
              return Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.03,
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile_img.png',
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              event.title!,
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.03,
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: const Icon(
                                Icons.more_horiz_rounded,
                                size: 28,
                              ))
                        ],
                      ),
                      Image.network(
                        event.images![0],
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded[index] = !isExpanded[index];
                          });
                        },
                        child: ExpandablePanel(
                          controller: ExpandableController(
                              initialExpanded: isExpanded[index]),
                          collapsed: Text(
                            "${event.description}",
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          expanded: Text("${event.description}"),
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                        bottom: MediaQuery.of(context).size.width * 0.01
                                      ),
                              child: const Icon(Icons.thumb_up_alt_outlined)),
                          Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                      bottom: MediaQuery.of(context).size.width * 0.01),
                              child: Text("${event.likes} Like")),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                        bottom: MediaQuery.of(context).size.width * 0.01
                                      ),
                              child: const Icon(Icons.mode_comment_outlined)),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                bottom: MediaQuery.of(context).size.width * 0.01),
                            child: const Text(" Comments"),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08, bottom: MediaQuery.of(context).size.width * 0.01),
                              child: const Icon(Icons.share)),
                          Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01, 
                              bottom: MediaQuery.of(context).size.width * 0.01),
                            child: const Text(" Share"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 7,
                    color: const Color.fromRGBO(198, 196, 196, 1),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
