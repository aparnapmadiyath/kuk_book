import 'package:flutter/material.dart';

import '../../../core/common/widgets/custom_text_widget.dart';
import '../../../main.dart';
import '../../../theme/palette.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map profileDetails = {
    "id": "66e994239654078fd531dc2a",
    "userName": "demo@aurify.ae",
    "companyName": "Aurify Solutions",
    "address": "Dubai",
    "email": "Aurify44@gmail.com",
    "contact": 971585023411,
    "whatsapp": 971585023411
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.blackColor,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            // color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        title: const CustomTextWidget(text: "Profile",color: Colors.black,weight: FontWeight.w700,fontSizeMultiplier: 0.05,),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: w*0.15),
            Center(
              child: CircleAvatar(
                radius: w*0.13,
                child: Icon(Icons.person,size: w*0.15,),
                // backgroundImage: AssetImage('assets/profile.jpg'), // Replace with network image if needed
              ),
            ),
            SizedBox(height: w*0.05),
            Text(
              profileDetails['companyName'],
              style: TextStyle(fontSize: w*0.065, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: w*0.02),
            Text(
              profileDetails['email'],
              style: TextStyle(fontSize: w*0.04, color: Colors.white),
            ),
            SizedBox(height: w*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_rounded,color: Colors.white,size: w*0.045,),
                SizedBox(width: w*0.03,),
                Text(
                  profileDetails['address'],
                  style: TextStyle(fontSize: w*0.04, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: w*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone,color: Colors.white,size: w*0.045,),
                SizedBox(width: w*0.03,),
                Text(
                  profileDetails['contact'].toString(),
                  style: TextStyle(fontSize: w*0.04, color: Colors.white),
                ),
              ],
            ),
            // SizedBox(height: w*0.02),
            // Text(
            //   profileDetails['whatsapp'].toString(),
            //   style: TextStyle(fontSize: w*0.04, color: Colors.white),
            // ),
          ],
        ),
      ),
    );
  }
}
