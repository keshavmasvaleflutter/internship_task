import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/view/home_screen.dart';
import 'package:task_1/view/search_screen.dart';

class BottomNavBar {
  static Widget bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(221, 22, 22, 22),
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search'),
      ],
      onTap: (index) {
        if (index == 0) {
          Get.offAll(() => HomeScreen());
        }
        if(index == 1) {
          Get.to(() => SearchScreen());
        }
      },
    );
  }
}
