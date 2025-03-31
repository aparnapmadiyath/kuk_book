import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';

import '../../../main.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade200,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(w*0.03),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Stack(
              children: [
                Container(
                  height: w*0.25,
                  // width: w*0.2,
                  color: Colors.green,
                ),
                Positioned(
                  right: w*0.02,
                  top: w*0.02,
                  child: CircleAvatar(
                    radius: w*0.03,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(CupertinoIcons.heart_fill,color: Colors.red,size: w*0.04,),
                  ),
                ),
              ],
            ),
            CustomTextWidget(text: 'product name',fontSizeMultiplier: 0.035,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(text: 'price',fontSizeMultiplier: 0.035,weight: FontWeight.bold,),
                Icon(CupertinoIcons.cart_fill_badge_plus,color: Colors.red,),   ],
            ),

          ],
        ),
      ),
    );
  }
}
