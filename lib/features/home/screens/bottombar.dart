import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kukbook/main.dart';
import 'package:kukbook/theme/palette.dart';

class BottomNavBar extends StatefulWidget {
   const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
List pages=const [
  Icon(Icons.home_filled),Icon(Icons.add),Icon(Icons.video_library_sharp)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Palette.whiteColor,
        color:  const Color(0xfff0f0f0),
        height: w*0.2,
          items: List.generate(pages.length, (index) => pages[index])),
    );
  }
}