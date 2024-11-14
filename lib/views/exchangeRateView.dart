import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aboutUsView.dart';
import 'contactUsView.dart';
import '../exchangeRateController.dart';
import 'newsView.dart';

class ExchangeRateView extends StatelessWidget {
  const ExchangeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Widget target;
              switch (value) {
                case 'News':
                  target = const NewsView();
                  break;
                case 'About Us':
                  target = const AboutUsView();
                  break;
                case 'Contact':
                  target = const ContactUsView();
                  break;
                default:
                  return;
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) => target));
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'News', child: Text('News')),
              PopupMenuItem(value: 'About Us', child: Text('About Us')),
              PopupMenuItem(value: 'Contact', child: Text('Contact')),
            ],
          ),
        ],
      ),
      body: Consumer<ExchangeRateController>(
        builder: (context, controller, _) {
          final padding = MediaQuery.of(context).size.width < 600 ? 8.0 : 16.0;
          return Column(
            children: [
              Expanded(
                child: controller.token == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                  padding: EdgeInsets.all(padding),
                  children: [
                    Text(
                      'Best Transaction Rates',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (controller.allBanksBestExchangeRates.isNotEmpty)
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('Currency')),
                          DataColumn(label: Text('Buying')),
                          DataColumn(label: Text('Selling')),
                          DataColumn(label: Text('Change')),
                        ],
                        rows: controller.allBanksBestExchangeRates
                            .map<DataRow>((item) => DataRow(cells: [
                          DataCell(Text(item['currency'])),
                          DataCell(Text(item['buying']['value'].toString())),
                          DataCell(Text(item['selling']['value'].toString())),
                          DataCell(Text(item['selling']['bank'])),
                        ]))
                            .toList(),
                      ),
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(padding),
                width: double.infinity,
                child: const Center(child: Text('Ethiopian Exchange Rate Data © 2024')),
              ),
            ],
          );
        },
      ),
    );
  }
}
