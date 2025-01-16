import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/bottom_nav_bar.dart';
import 'package:meditation_app/breathing_screen.dart';
import 'package:meditation_app/meditation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF6F0FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.person),
        titleSpacing: 0,
        title: Text(
          "Hello, Miranda",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.leaderboard, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.59,
                child: Text(
                  "Take a deep breath and relax.",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                  onTap: () {
                    Get.to(() => MeditationScreen());
                  },
                  child: Image.asset(
                    "assets/images/start_meditation.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: screenHeight * 0.013),
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(() => Breathing());
                          },
                          child: Image.asset(
                            "assets/images/breathing.png",
                            width: screenWidth * 0.44,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.028),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(() => MeditationScreen());
                          },
                          child: Image.asset(
                            "assets/images/soundspace.png",
                            width: screenWidth * 0.44,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: screenHeight * 0.014),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => Breathing());
                          },
                          child: Image.asset(
                            "assets/images/moodtracker.png",
                            width: screenWidth * 0.44,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "To Calm Your Nerves",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: 205,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildHorizontalCard(
                      title: "Soothing Soundscape",
                      subtitle: "50 Minutes",
                      imageUrl: "assets/images/girl.png",
                    ),
                    _buildHorizontalCard(
                      title: "Quick Breathing Exercise",
                      subtitle: "2 Minutes",
                      imageUrl: "assets/images/girl.png",
                    ),
                    _buildHorizontalCard(
                      title: "Guided Meditation",
                      subtitle: "8 Minutes",
                      imageUrl: "assets/images/girl.png",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar.bottomNavBar(),
    );
  }

  Widget _buildHorizontalCard({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
