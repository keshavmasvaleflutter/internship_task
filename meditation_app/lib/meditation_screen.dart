import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});
  @override
  State<StatefulWidget> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State {
  bool isPlaying = false;
    void togglePlayPause() {
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Body Scan Meditation",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: screenWidth*0.03,),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.035,
                  right: screenWidth * 0.035,
                  top: screenHeight * 0.008,
                  bottom: screenHeight * 0.01),
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/meditation_img.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.054, right: screenWidth * 0.054),
              child: Column(
                children: [
                  Slider(
                    value: 3.54, // Current time in min
                    min: 0,
                    max: 15.10, // Total time in min
                    onChanged: (value) {},
                    activeColor: Colors.purple,
                    inactiveColor: Colors.grey[300],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.054, right: screenWidth * 0.054),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("3:54", style: TextStyle(color: Colors.grey)),
                        Text("15:10", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Playback controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.purple, size: 32),
                  onPressed: () {},
                ),
                SizedBox(width: screenWidth * 0.08),
                ElevatedButton(
                  onPressed: () {
                    togglePlayPause();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.purple,
                  ),
                  child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white, size: 32),
                ),
                SizedBox(width: screenWidth * 0.06),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.purple, size: 32),
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Gradually focus on different parts of your body to release tension and promote relaxation.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
