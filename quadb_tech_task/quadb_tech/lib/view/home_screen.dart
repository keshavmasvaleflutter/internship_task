import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_1/view/detail_screen.dart';
import 'package:task_1/view/search_screen.dart';
import '../controller/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 22, 22, 22),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, screenHeight * 0.06, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.25,
                ),
                Image.asset(
                  'assets/logos_netflix.png',
                  height: screenHeight * 0.045,
                ),
                SizedBox(
                  width: screenWidth * 0.19,
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                ),
              ],
            ),
            movies.isEmpty
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.22,
                      screenWidth * 0.6,
                      screenWidth * 0.2,
                      screenWidth * 0.05,
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Colors.red,
                      strokeAlign: 1,
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index]['show'];
                        return Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(DetailsScreen(movie: movie));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie name
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: Text(
                                    movie['name'] ?? 'No Title',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Movie image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    movie['image']?['medium'] ??
                                        'https://via.placeholder.com/150',
                                    height: screenHeight * 0.26,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text(
                                        'Failed to load image',
                                        style: TextStyle(color: Colors.red),
                                      );
                                    },
                                  ),
                                ),
                                // Movie summary
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    movie['summary']?.replaceAll(
                                            RegExp('<[^>]*>'), '') ??
                                        'No Summary',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar.bottomNavBar(),
    );
  }
}
