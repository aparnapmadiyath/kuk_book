import 'package:flutter/material.dart';
import 'package:kukbook/features/arsha_task/screens/card.dart';

import '../../../core/common/widgets/custom_text_widget.dart';
import '../../../main.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: const CustomTextWidget(
          text: "Shop",
          color: Colors.black,
          weight: FontWeight.w700,
          fontSizeMultiplier: 0.05,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(w*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: w * 0.02,
                crossAxisSpacing: w * 0.02,
                childAspectRatio: 0.8,
              ),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardWidget();
              },
            )
          ],
        ),
      ),
    );
  }
}
