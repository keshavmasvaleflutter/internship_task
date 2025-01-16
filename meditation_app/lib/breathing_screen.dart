import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Breathing extends StatefulWidget {
  const Breathing({super.key});
  @override
  State<StatefulWidget> createState() => _BreathingState();
}

class _BreathingState extends State<Breathing> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    setState(() => _isRunning = false);
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _seconds = 0;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          "Breathing Exercise",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.008, bottom: screenHeight * 0.01),
            height: screenHeight * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/nose.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.38,
                screenHeight * 0.01, screenWidth * 0.38, screenHeight * 0.03),
            child: Text(
              _formatTime(_seconds),
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.054, right: screenWidth * 0.054),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenHeight * 0.055,
                  width: screenWidth * 0.43,
                  child: ElevatedButton(
                    onPressed: _isRunning
                        ? _pauseTimer
                        : _startTimer,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isRunning ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: screenWidth*0.045,),
                        Text(
                          _isRunning ? "Pause" : "Start",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                SizedBox(
                  height: screenHeight * 0.055,
                  width: screenWidth * 0.43,
                  child: ElevatedButton(
                      onPressed: _resetTimer,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.08,
          ),
          SizedBox(
            height: screenHeight * 0.055,
            width: screenWidth * 0.9,
            child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.grey, width: 2)),
                  ),
                ),
                child: Text(
                  "Done",
                  style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 17),
                )),
          ),
        ],
      ),
    );
  }
}
