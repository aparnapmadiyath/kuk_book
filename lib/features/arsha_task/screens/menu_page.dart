import 'package:flutter/material.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/arsha_task/screens/page_2.dart';
import 'package:kukbook/features/arsha_task/screens/menu_tile.dart';
import 'package:kukbook/features/arsha_task/screens/profile_page.dart';
import 'package:kukbook/features/arsha_task/screens/shop.dart';
import 'package:kukbook/theme/palette.dart';

import 'bank_details.dart';
import 'final_screen.dart';
import '../../home/screens/home_page.dart';
import 'news_listing.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Palette.blackColor,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: const CustomTextWidget(text: "Menu",color: Colors.black,weight: FontWeight.w700,fontSizeMultiplier: 0.05,),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileTile(title: 'Profile', subTitle: 'subTitle', page: ProfilePage()),
              ProfileTile(title: 'Categories', subTitle: 'subTitle', page: ShopPage()),
              const ProfileTile(title: 'Bank Details', subTitle: 'subTitle', page: BankDetails()),
              const ProfileTile(title: 'News', subTitle: 'subTitle', page: NewsListingPage()),
            ],
          ),
        ),
      ),
    );
  }
}
