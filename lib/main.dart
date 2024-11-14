import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exchangeRateController.dart';
import 'views/exchangeRateView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Exchange Rates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ExchangeRateController()..login(), // Trigger login on startup
        child: const ExchangeRateView(),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ExchangeRateScreen(),
//     );
//   }
// }
//
// class ExchangeRateScreen extends StatelessWidget {
//   final List<Map<String, String>> banks = [
//     {'name': 'CBE', 'buying': '119.5', 'selling': '135.2'},
//     {'name': 'DASHEN', 'buying': '119.5', 'selling': '135.2'},
//     {'name': 'AWASH', 'buying': '119.5', 'selling': '135.2'},
//     {'name': 'ABYSSIN.', 'buying': '119.5', 'selling': '135.2'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[800],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 20,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     "Today Exchange Rate",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               // Currency buttons row
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     _currencyButton("USD", true),
//                     const SizedBox(width: 8),
//                     _currencyButton("EURO"),
//                     const SizedBox(width: 8),
//                     _currencyButton("GBP"),
//                     const SizedBox(width: 8),
//                     _currencyButton("AED"),
//                     const SizedBox(width: 8),
//                     _currencyButton("YUAN"),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Table header
//               Row(
//                 children: [
//                   Expanded(flex: 3, child: _headerText("BANK")),
//                   Expanded(flex: 2, child: _headerText("BUYING")),
//                   Expanded(flex: 2, child: _headerText("SELLING")),
//                   Expanded(flex: 1, child: _headerText("CHANGE")),
//                 ],
//               ),
//               const SizedBox(height: 8),
//
//               // Bank data rows
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: banks.length,
//                   itemBuilder: (context, index) {
//                     return _bankRow(banks[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _currencyButton(String text, [bool selected = false]) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: selected ? Colors.purple[300] : Colors.grey[200],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: selected ? Colors.white : Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _headerText(String text) {
//     return Center(
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _bankRow(Map<String, String> bank) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6.0),
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.blue[900],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(
//                 bank['name']!,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: Text(
//                 bank['buying']!,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: Text(
//                 bank['selling']!,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           const Expanded(
//             flex: 1,
//             child: Center(
//               child: Icon(Icons.show_chart, color: Colors.white, size: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
