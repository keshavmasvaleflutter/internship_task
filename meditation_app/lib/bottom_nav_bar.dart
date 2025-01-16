import 'package:flutter/material.dart';

class BottomNavBar {
  static Widget bottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/solar_meditation_bold.png",
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/solar_heart_pulse_bold.png",
          ),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.music_note,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2,
            ),
            label: ""
          ),
      ],
    );
  }
}
