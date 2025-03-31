import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kukbook/theme/palette.dart';
import 'package:marquee/marquee.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../main.dart';
import 'chart_page.dart';

class SpotRate extends StatefulWidget {
  const SpotRate({super.key});

  @override
  State<SpotRate> createState() => _SpotRateState();
}

class _SpotRateState extends State<SpotRate> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int currentIndex = 0;

  final List<Map<String, dynamic>> metals = [
    {
      "name": "Gold",
      "bid": 2919.75,
      "ask": 2920.43,
      "low": 2913.70,
      "high": 2930.10,
      "color": Palette.goldColor
      // "color": Colors.amber
    },
    {
      "name": "Silver",
      "bid": 31.79,
      "ask": 31.817,
      "low": 31.677,
      "high": 31.813,
      "color": Palette.silverColor
      // "color": Colors.grey
    },
    {
      "name": "Copper",
      "bid": 8.15,
      "ask": 8.20,
      "low": 8.05,
      "high": 8.30,
      "color": Palette.copperColor
      // "color": Colors.brown
    },
    {
      "name": "Platinum",
      "bid": 965.50,
      "ask": 970.30,
      "low": 960.00,
      "high": 975.40,
      "color": Palette.platinumColor
      // "color": Colors.blueGrey
    },
  ];

  Widget _buildRateCard({
    required String title,
    required String bid,
    required String ask,
    required String low,
    required String high,
    required Color color,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // color: isDarkMode ? Colors.grey[850] : Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: w * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BID: $bid',
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'ASK: $ask',
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LOW: $low',
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'HIGH: $high',
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: w*0.15,),
              Center(
                child: Text(
                  "SPOT RATE",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: w * 0.05),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 200),
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {});
                  },
                  height: w * 0.4,
                  // enlargeCenterPage: true
                ),
                items: metals.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return _buildRateCard(
                        title: i['name'],
                        bid: i['bid'].toString(),
                        ask: i['ask'].toString(),
                        low: i['low'].toString(),
                        high: i['high'].toString(),
                        color: i['color'],
                        isDarkMode: false,
                      );
                    },
                  );
                }).toList(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: w * 0.03),
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentIndex,
                    count: metals.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: w * 0.02,
                      dotWidth: w * 0.02,
                      spacing: 6,
                      dotColor: Colors.amber.shade50,
                      activeDotColor: Colors.amber,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              CommodityRatesTable(),
              SizedBox(
                height: w*0.05,
              ),
              SizedBox(
                height: w * 0.1,
                child: Marquee(
                  text: 'Some sample text that takes some space.',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w*0.045),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
