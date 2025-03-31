import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kukbook/features/arsha_task/screens/menu_page.dart';
import 'package:kukbook/main.dart';

import '../../arsha_task/screens/final_screen.dart';
import '../../arsha_task/screens/live_data.dart';

class BottomNavBarA extends ConsumerStatefulWidget {
  const BottomNavBarA({super.key});

  @override
  ConsumerState<BottomNavBarA> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBarA> {
  final indexProvider=StateProvider<int>((ref) => 0);
  List pages=const [
    Icon(Icons.home_filled),Icon(Icons.add),Icon(Icons.video_library_sharp)
  ];

  Widget buildBody(){
    switch (ref.watch(indexProvider)){
      case 0:
        return const SpotRate();
      case 1:
        return const MarketDataScreen();
      default:
        return const MenuPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.black,
          buttonBackgroundColor: Colors.amber,
          color: Colors.amber,
          // color:  const Color(0xfff0f0f0),
          height: w*0.2,
          onTap: (value) {
            ref.read(indexProvider.notifier).update((state) => value);
          },
          items: List.generate(pages.length, (index) => pages[index])),
    );
  }
}