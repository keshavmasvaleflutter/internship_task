import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internship_demo_app/model/fetch_data_model.dart';
import 'home_page.dart';
import 'liked_screen.dart';
import 'saved_screen.dart';

dynamic obj;

List<Events>? newsData = [];
bool isLoading = true;

void callTofetchNewsData(int count) {
  obj.fetchNewsData(1);
}

class NavigatonPage extends StatefulWidget {
  const NavigatonPage({super.key});
  @override
  // ignore: no_logic_in_create_state
  State createState() {
    obj = _HomePageState();
    return obj;
  }
}

class _HomePageState extends State<NavigatonPage> {
  void fetchNewsData(int count) async {
    Uri url = Uri.parse("https://evika.onrender.com/api/event");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      FetchDataModel fetchDataModel = FetchDataModel(responseData);

      if (fetchDataModel.data != null && fetchDataModel.data!.events != null) {
        setState(() {
          if (count == 0) {
            newsData = fetchDataModel.data!.events;
            insertEventsData(newsData!);
            isLoading = false;
          } else {
            newsData?.addAll(fetchDataModel.data!.events as Iterable<Events>);
            isLoading = false;
          }
        });
      }
    } else {
      log("Failed to fetch data. Status code: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNewsData(0);
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const LikedScreen(),
    const SavedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget dataConfirmation() {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 5,
      ));
      // return const SavedScreen();
    } else {
      return _pages[_selectedIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
        centerTitle: true,
        leading: const Icon(Icons.menu_outlined),
        actions: [
          Image.asset("assets/images/notification_img.png"),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08)
        ],
        title: Text(
          "DEMO APP",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: dataConfirmation(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.005,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Liked',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.comment_outlined),
              //   label: 'Community',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: 'Saved',
              )
            ],
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
