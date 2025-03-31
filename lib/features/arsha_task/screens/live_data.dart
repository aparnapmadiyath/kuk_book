import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;


class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  MarketDataScreenState createState() => MarketDataScreenState();
}

class MarketDataScreenState extends State<MarketDataScreen> {
  final String adminId = '66e994239654078fd531dc2a';
  final String socketSecretKey = 'aurify@123';
  final String baseUrl = "https://api.task.aurify.ae";

  Map<String, dynamic> marketData = {};
  List<dynamic> commodities = [];
  String? serverURL;
  List<dynamic> news = [];
  String? error;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List commoditiesList=[];

  Future<void> fetchData() async {
    try {
      final spotRatesRes = await fetchSpotRates(adminId);
      final serverURLRes = await fetchServerURL();
      // final newsRes = await fetchNews(adminId);
      final commoditiesRes = await fetchCommodities(adminId);
      setState(() {
        commodities = commoditiesRes['commodities'];
        // commoditiesList=spotRatesRes['info']['commodities'];
        commoditiesList = spotRatesRes['info']['commodities'].map((item) {
          if (item is String) {
            return jsonDecode(item); // Parse string to map
          }
          return item; // Assume it's already a map
        }).toList();
        serverURL = serverURLRes['info']['serverURL'];
        // news = newsRes['news']['news'];
      });
      if (serverURL != null) {
        print("Connecting to WebSocket server at $serverURL");
        connectSocket(serverURL!);
      }
    } catch (e) {
      print(e);
      setState(() => error = "An error occurred while fetching data");
      print("Error fetching data: $e");
    }
  }

  void connectSocket(String url) {
    IO.Socket socket = IO.io(url, <String, dynamic>{
      'query': {'secret': socketSecretKey},
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (data) {
      print('Connected to WebSocket server');
      Timer.periodic(Duration(seconds: 1), (timer) {
        socket.emit('request-data', [commodities]);
      });
    });


    socket.on('disconnect', (_) => print('Disconnected from WebSocket server'));

    socket.on('market-data', (data) {
      print("data $data");
      // print("dataepic============ ${data['epic']}");
      // print("marketData=====$marketData======= ${data['epic']}");
      if (data != null
          // && data['epic'] != null
      ) {
        if(data['epic'] != null){
          setState(() {
            marketData[data['epic']] = {
              ...?marketData[data['epic']],
              ...data,
              'bidChanged': marketData[data['epic']] != null && data['bid'] != marketData[data['epic']]['bid']
                  ? (data['bid'] > marketData[data['epic']]['bid'] ? 'up' : 'down')
                  : null,
            };
          });
        }

      } else {
        print("Received malformed market data: $data");
      }
    });

    socket.on('error', (error) {
      print("WebSocket error: $error");
      setState(() => this.error = "An error occurred while receiving data");
    });
  }
  Map<String, dynamic> getPrice({required Map<String, dynamic> commodity}) {
    double bid = double.parse(marketData[commodity['metal'].toUpperCase()]['bid'].toString());
    double ask = double.parse(marketData[commodity['metal'].toUpperCase()]['offer'].toString());
    double unit = double.parse(commodity['unit'].toString());
    String weight = commodity['weight'];
    double buyCharge = double.parse(commodity['buyCharge'].toString());
    double sellCharge = double.parse(commodity['sellCharge'].toString());
    double buyPremium = double.parse(commodity['buyPremium'].toString());
    double sellPremium = double.parse(commodity['sellPremium'].toString());
    double purity = double.parse(commodity['purity'].toString());

    Map<String, double> unitMultiplierMap = {
      "GM": 1.0,
      "KG": 1000.0,
      "TTB": 116.64,
      "TOLA": 11.664,
      "OZ": 31.1034768,
    };

    double unitMultiplier = unitMultiplierMap[weight] ?? 1.0;
    double purityPower = purity / 1000;

    double biddingValue = bid + buyPremium;
    double askingValue = ask + sellPremium;
    double biddingPrice = (biddingValue / 31.103) * 3.674;
    double askingPrice = (askingValue / 31.103) * 3.674;

    double buyPrice = (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
    double sellPrice = (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;

    return {
      "buy": buyPrice,
      "sell": sellPrice,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Market Data")),
      body: Center(
        child: marketData.isEmpty
            ? CircularProgressIndicator()
            : error != null
            ? Text(error!)
            : SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: commodities.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(commodities[index].toString()),
                    subtitle: Column(
                      children: [
                        Text("Bid: ${marketData[commodities[index].toUpperCase()]['bid']}"),
                        Text("Ask: ${marketData[commodities[index].toUpperCase()]['offer']}"),
                        Text("low: ${marketData[commodities[index].toUpperCase()]['low']}"),
                        Text("high: ${marketData[commodities[index].toUpperCase()]['high']}"),
                      ],
                    ),
                  );
                },
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                itemCount: commoditiesList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var commodity = commoditiesList[index];
                  print('-------------------------');
                  print(commoditiesList.length);
                  print(commodity);
                  if (commodity is Map<String, dynamic>) {
                    return ListTile(
                      title: Text("${commodity['metal']} ${commodity['purity']}"),
                      subtitle: Column(
                        children: [
                          Text("Sell: ${getPrice(commodity: commodity)['sell']}"),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text("Invalid commodity data"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Map<String, dynamic> getPrice({required var commodity}){
  //   double bid = double.parse(marketData[commodity['metal'].toUpperCase()]['bid'].toString());
  //   double ask =double.parse( marketData[commodity['metal'].toUpperCase()]['offer'].toString());
  //   double unit = double.parse(commodity['unit'].toString());
  //   String weight =  commodity['weight'];
  //   double buyCharge = double.parse( commodity['buyCharge'].toString());
  //   double sellCharge =double.parse(  commodity['sellCharge'].toString());
  //   double buyPremium =double.parse( commodity['buyPremium'].toString());
  //   double sellPremium =double.parse( commodity['sellPremium'].toString());
  //   double purity = double.parse(commodity['purity'].toString());
  //
  //   Map<String, double> unitMultiplierMap = {
  //     "GM": 1.0,
  //     "KG": 1000.0,
  //     "TTB": 116.64,
  //     "TOLA": 11.664,
  //     "OZ": 31.1034768,
  //   };
  //
  //   double unitMultiplier = unitMultiplierMap[weight] ?? 1.0;
  //   double purityPower = purity/1000;
  //
  //   double biddingValue = bid + buyPremium;
  //   double askingValue = ask + sellPremium;
  //   double biddingPrice = (biddingValue / 31.103) * 3.674;
  //   double askingPrice = (askingValue / 31.103) * 3.674;
  //
  //   double buyPrice = (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
  //   double sellPrice = (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;
  //   return {
  //     "buy":buyPrice,
  //     "sell": sellPrice,
  //   };
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Market Data")),
  //     body: Center(
  //       child:marketData.isEmpty?CircularProgressIndicator(): error != null
  //           ? Text(error!)
  //           : SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             ListView.builder(
  //               itemCount: commodities.length,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 return ListTile(title: Text(commodities[index].toString()),subtitle: Column(
  //                   children: [
  //                     Text("Bid: ${marketData[commodities[index].toUpperCase()]['bid']}"),
  //                     Text("Ask: ${marketData[commodities[index].toUpperCase()]['offer']}"),
  //                     Text("low: ${marketData[commodities[index].toUpperCase()]['low']}"),
  //                     Text("high: ${marketData[commodities[index].toUpperCase()]['high']}"),
  //                   ],
  //                 ),);
  //               },
  //             ),
  //             ListView.builder(
  //               physics: ScrollPhysics(),
  //               itemCount: commoditiesList.length,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 return ListTile(title: Text("${commoditiesList[index]['metal']} ${commoditiesList[index]['purity']}".toString()),subtitle: Column(
  //                   children: [
  //                     Text("Sell: ${getPrice(commodity: commoditiesList[index])['sell']}"),
  //                     // Text("Buy: ${marketData[commodities[index]]['offer']}"),
  //                   ],
  //                 ),);
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Future<Map<String, dynamic>> fetchSpotRates(String adminId) async {
  var headers = {
    'X-Secret-Key': 'IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb'
  };
  var request = http.Request('GET', Uri.parse('https://api.task.aurify.ae/user/get-spotrates/$adminId'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  var res=await response.stream.bytesToString();

  return response.statusCode == 200 ? jsonDecode(res) : throw Exception("Failed to load spot rates");
}

Future<Map<String, dynamic>> fetchServerURL() async {
  var headers = {
    'X-Secret-Key': 'IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb'
  };
  var request = http.Request('GET', Uri.parse('https://api.task.aurify.ae/user/get-server'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var res=await response.stream.bytesToString();
  return response.statusCode == 200 ? jsonDecode(res) : throw Exception("Failed to load server URL");
}

// Future<Map<String, dynamic>> fetchNews(String adminId) async {
//   final response = await http.get(Uri.parse('https://api.task.aurify.ae/get-news/$adminId'));
//   return response.statusCode == 200 ? jsonDecode(response.body) : throw Exception("Failed to load news");
// }

Future<Map<String, dynamic>> fetchCommodities(String adminId) async {
  var headers = {
    'X-Secret-Key': 'IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb'
  };
  var request = http.Request('GET', Uri.parse('https://api.task.aurify.ae/user/get-commodities/$adminId'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var res=await response.stream.bytesToString();
  return response.statusCode == 200 ? jsonDecode(res) : throw Exception("Failed to load commodities");
}





// #Calculations
// bidding price = bid + bid spread
// (bidding price + buyPremium /31.103)*3.674 * gross weight * purity + buyCharge

// asking price = bidding price + ask spread + 0.5 (For gold 0.5 and silver, platinum, copper 0.05)
// (asking price + sellPremium /31.103)*3.674 * gross weight * purity + sellCharge


// void processCommodity(Map<String, dynamic> commodity) {
//   double bid = getBidAskValue(commodity['metal'].toLowerCase());
//   double ask = getBidAskValue(commodity['metal'].toLowerCase());

//   double unit = (commodity['unit'] as num).toDouble();
//   String weight = commodity['weight'];
//   double buyCharge = (commodity['buyCharge'] as num).toDouble();
//   double sellCharge = (commodity['sellCharge'] as num).toDouble();
//   double buyPremium = (commodity['buyPremium'] as num).toDouble();
//   double sellPremium = (commodity['sellPremium'] as num).toDouble();
//   double purity = (commodity['purity'] as num).toDouble();

//   Map<String, double> unitMultiplierMap = {
//     "GM": 1.0,
//     "KG": 1000.0,
//     "TTB": 116.64,
//     "TOLA": 11.664,
//     "OZ": 31.1034768,
//   };

//   double unitMultiplier = unitMultiplierMap[weight] ?? 1.0;
//   // double purityPower = calculatePurityPower(purity);
//   double purityPower = purity;

//   double biddingValue = bid + buyPremium;
//   double askingValue = ask + sellPremium;
//   double biddingPrice = (biddingValue / 31.103) * 3.674;
//   double askingPrice = (askingValue / 31.103) * 3.674;

//   double buyPrice = (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
//   double sellPrice = (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;

//   print("Buy Price: \$buyPrice, Sell Price: \$sellPrice");
// }

getPrice({required Map<String, dynamic> commodity}){

}