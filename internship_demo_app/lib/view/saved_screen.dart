import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_demo_app/model/database.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State createState() => _SavedScreenPage();
}

class _SavedScreenPage extends State<SavedScreen> {
  late Future<List<NewsAppData>> _newsDataFuture;

  @override
  void initState() {
    super.initState();
    _newsDataFuture = getNewsAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved News"),
      ),
      body: FutureBuilder<List<NewsAppData>>(
        future: _newsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            final newsDataList = snapshot.data!;
            List<bool> isExpanded = List<bool>.filled(newsDataList.length, false);

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: newsDataList.length,
              itemBuilder: (context, index) {
                final event = newsDataList[index];

                return Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.03,
                                vertical: MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/profile_img.png',
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${event.title}",
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
                                right: MediaQuery.of(context).size.width * 0.03,
                              ),
                              child: const Icon(
                                Icons.more_horiz_rounded,
                                size: 28,
                              ),
                            ),
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
                              initialExpanded: isExpanded[index],
                            ),
                            collapsed: Text(
                              "${event.description}",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
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
                                left: MediaQuery.of(context).size.width * 0.08,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: const Icon(Icons.thumb_up_alt_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: Text("${event.likes} Like"),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.08,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: const Icon(Icons.mode_comment_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: const Text(" Comments"),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.08,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: const Icon(Icons.share),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                bottom: MediaQuery.of(context).size.width * 0.01,
                              ),
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
            );
          }
        },
      ),
    );
  }
}
