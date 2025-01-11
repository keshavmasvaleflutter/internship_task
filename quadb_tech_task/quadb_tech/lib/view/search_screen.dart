import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_1/view/detail_screen.dart';

import '../controller/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies...',
          ),
          onSubmitted: (query) => searchMovies(query),
        ),
      ),
      body: searchResults.isEmpty
          ? Center(child: Text('No results found'))
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index]['show'];
                return ListTile(
                  leading: Image.network(movie['image']?['medium'] ?? '',
                      fit: BoxFit.cover),
                  title: Text(movie['name'] ?? 'No Title'),
                  subtitle: Text(
                      movie['summary']?.replaceAll(RegExp('<[^>]*>'), '') ??
                          'No Summary'),
                  onTap: () {
                    Get.to(DetailsScreen(movie: movie));
                  },
                );
              },
            ),
            bottomNavigationBar: BottomNavBar.bottomNavBar(),
    );
  }
}
