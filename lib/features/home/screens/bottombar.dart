import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kukbook/features/arsha_task/screens/menu_page.dart';
import 'package:kukbook/main.dart';
import 'package:kukbook/theme/palette.dart';

import '../../arsha_task/screens/final_screen.dart';
import '../../arsha_task/screens/live_data.dart';
import 'diet1.dart';
import 'diet2.dart';
import 'home_page.dart';

class BottomNavBar extends ConsumerStatefulWidget {
   const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  final indexProvider=StateProvider<int>((ref) => 0);
List pages=const [
  Icon(Icons.home_filled),Icon(Icons.add),Icon(Icons.video_library_sharp)
  ];

Widget buildBody(){
  switch (ref.watch(indexProvider)){
    case 0:
      return const MyHomePage();
    case 1:
      return const Diet1();
    default:
      return const Diet2();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor:Palette.primaryColor,
        color: Palette.primaryColor,
        // color:  const Color(0xfff0f0f0),
        height: w*0.2,
          onTap: (value) {
            ref.read(indexProvider.notifier).update((state) => value);
          },
          items: List.generate(pages.length, (index) => pages[index])),
    );
  }
}