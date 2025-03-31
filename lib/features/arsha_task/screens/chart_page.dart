import 'package:flutter/material.dart';

class GoldRatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gold & Silver Rates'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SpotRateCard(),
            SizedBox(height: 16),
            CommodityRatesTable(),
          ],
        ),
      ),
    );
  }
}

class SpotRateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Spot Rates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gold (Oz)', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Bid: 2919.75', style: TextStyle(color: Colors.green)),
                    Text('Ask: 2920.43', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Silver (Oz)', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Bid: 31.79', style: TextStyle(color: Colors.green)),
                    Text('Ask: 31.817', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommodityRatesTable extends StatelessWidget {
  final List<Map<String, String>> commodityRates = [
    {'commodity': 'Gold 9999', 'weight': '1 GM', 'price': '346.03'},
    {'commodity': 'Gold 9999', 'weight': '1 KG', 'price': '346,029'},
    {'commodity': 'Gold 995', 'weight': '1 KG', 'price': '344,299'},
    {'commodity': 'Gold 999', 'weight': '1 TTB', 'price': '40,321'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Commodity Rates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Commodity',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Weight',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Price (AED)',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                ...commodityRates.map(
                  (rate) => TableRow(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(rate['commodity']!)),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(rate['weight']!)),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(rate['price']!)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
