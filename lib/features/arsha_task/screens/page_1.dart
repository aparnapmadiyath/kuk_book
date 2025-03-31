
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'BullionState',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? Colors.amber : Colors.black,
            ),
            onPressed: _toggleDarkMode,
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: _isDarkMode ? Colors.white : Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(_isDarkMode),
              SizedBox(height: 20),
              _buildSpotRateSection(_isDarkMode),
              SizedBox(height: 20),
              _buildCommodityDetails(_isDarkMode),
              SizedBox(height: 20),
              _buildInteractiveButtons(_isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '26FEB2025',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            Text(
              '09:15 AM',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.amber[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.battery_charging_full, color: isDarkMode ? Colors.amber : Colors.amber[800]),
              SizedBox(width: 5),
              Text(
                '29%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.amber : Colors.amber[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpotRateSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spot Rate',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 10),
        _buildRateCard(
          title: 'GOLD',
          bid: '2919.75',
          ask: '2920.43',
          low: '2913.70',
          high: '2930.10',
          color: Colors.amber[700]!,
          isDarkMode: isDarkMode,
        ),
        SizedBox(height: 10),
        _buildRateCard(
          title: 'Silver',
          bid: '31.790',
          ask: '31.817',
          low: '31.677',
          high: '31.813',
          color: Colors.grey[700]!,
          isDarkMode: isDarkMode,
        ),
        SizedBox(height: 10),
        _buildRateCard(
          title: 'Platinum',
          bid: '950.50',
          ask: '952.30',
          low: '945.20',
          high: '955.80',
          color: Colors.blue[700]!,
          isDarkMode: isDarkMode,
        ),
        SizedBox(height: 10),
        _buildRateCard(
          title: 'Copper',
          bid: '4.25',
          ask: '4.30',
          low: '4.20',
          high: '4.35',
          color: Colors.orange[700]!,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

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
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BID: $bid', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
                Text('ASK: $ask', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('LOW: $low', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
                Text('HIGH: $high', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommodityDetails(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Commodity Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 10),
        _buildDetailItem('GOLD9999', '1GM', '346.03 AED', isDarkMode),
        _buildDetailItem('GOLD9999', '1KG', '346,029 AED', isDarkMode),
        _buildDetailItem('GOLD995', '1KG', '344,299 AED', isDarkMode),
        _buildDetailItem('GOLD999', '1TTB', '40,321 AED', isDarkMode),
        _buildDetailItem('Platinum', '1OZ', '950.50 AED', isDarkMode),
        _buildDetailItem('Copper', '1KG', '4.25 AED', isDarkMode),
      ],
    );
  }

  Widget _buildDetailItem(String commodity, String weight, String price, bool isDarkMode) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        '$commodity ($weight)',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Text(
        price,
        style: TextStyle(
          fontSize: 18,
          color: Colors.amber[800],
        ),
      ),
    );
  }

  Widget _buildInteractiveButtons(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.notifications_active),
          label: Text('Rate Alert'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[800],
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.message),
          label: Text('WhatsApp'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}