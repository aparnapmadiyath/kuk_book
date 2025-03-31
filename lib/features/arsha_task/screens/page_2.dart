import 'package:flutter/material.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/arsha_task/screens/chart_page.dart';

import '../../../main.dart';

class SpotRateScreen extends StatelessWidget {
  final List<Map<String, dynamic>> metals = [
    {
      "name": "Gold",
      "bid": 2919.75,
      "ask": 2920.43,
      "low": 2913.70,
      "high": 2930.10,
      "color": Colors.amber
    },
    {
      "name": "Silver",
      "bid": 31.79,
      "ask": 31.817,
      "low": 31.677,
      "high": 31.813,
      "color": Colors.grey
    },
    {
      "name": "Copper",
      "bid": 8.15,
      "ask": 8.20,
      "low": 8.05,
      "high": 8.30,
      "color": Colors.brown
    },
    {
      "name": "Platinum",
      "bid": 965.50,
      "ask": 970.30,
      "low": 960.00,
      "high": 975.40,
      "color": Colors.blueGrey
    },
  ];

  Widget buildPriceRow(String label, double value, {bool isSecondary = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: "$label: ",
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSecondary ? Colors.grey.shade700 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text("THANGALS",
      //       style: TextStyle(letterSpacing: 1.5, color: Colors.black)),
      //   centerTitle: true,
      //   backgroundColor: Colors.amber,
      // ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "SPOT RATE",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: w*0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: w*0.03),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: metals.length,
                  itemBuilder: (context, index) {
                    final metal = metals[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.amber.shade200, // Background color
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Metal Name & Icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  metal["name"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: metal["color"],
                                  size: 16,
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey.shade300, thickness: 1),
        
                            // Prices Information with Bid & Low on Left, Ask & High on Right
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // buildPriceRow("Bid", metal["bid"]),
                                    Text(
                                      "BID",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.01),
                                      color: Colors.red
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(vertical: w*0.01,horizontal: w*0.015),
                                        child:Text(
                                          "${metal["bid"].toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ) ,
                                      ),
                                    ),
                                    Text(
                                      "Low",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "${metal["low"].toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    // buildPriceRow("Low", metal["low"], isSecondary: true),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "ASK",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(w * 0.01),
                                          color: Colors.green
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(vertical: w*0.01,horizontal: w*0.015),
                                        child: Text(
                                          "${metal["ask"].toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "High",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "${metal["high"].toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    // buildPriceRow("Ask",),
                                    // buildPriceRow("High", metal["high"], isSecondary: true),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              CommodityRatesTable()
            ],
          ),
        ),
      ),
    );
  }
}
