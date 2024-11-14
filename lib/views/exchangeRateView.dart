import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aboutUsView.dart';
import 'contactUsView.dart';
import '../exchangeRateController.dart';
import 'newsView.dart';

class ExchangeRateView extends StatefulWidget {
  const ExchangeRateView({super.key});

  @override
  _ExchangeRateViewState createState() => _ExchangeRateViewState();
}

class _ExchangeRateViewState extends State<ExchangeRateView> {
  String selectedCurrency = 'USD'; // default selected currency

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today Exchange Rate'),
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => target));
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
              // Currency selection tabs
              Container(
                color: Colors.blue[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['USD', 'EURO', 'GBP', 'AED', 'YUAN']
                        .map((currency) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCurrency = currency;
                        });
                        controller.fetchExchangeRatesForCurrency(
                            selectedCurrency);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: selectedCurrency == currency
                              ? Colors.purple[400]
                              : Colors.blue[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          currency,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                child: controller.token == null
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: EdgeInsets.all(padding),
                  child: ListView(
                    children: [
                      const Text(
                        'Buying and Selling Rates',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (controller.allBanksBestExchangeRates.isNotEmpty)
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Bank')),
                            DataColumn(label: Text('Buying')),
                            DataColumn(label: Text('Selling')),
                            DataColumn(label: Text('Change')),
                          ],
                          rows: controller.allBanksBestExchangeRates
                              .map<DataRow>((item) => DataRow(cells: [
                            DataCell(Text(item['bank'])),
                            DataCell(Text(item['buying']
                            ['value']
                                .toString())),
                            DataCell(Text(item['selling']
                            ['value']
                                .toString())),
                            DataCell(
                              Icon(Icons.show_chart),
                            ),
                          ]))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.blue[800],
                padding: EdgeInsets.all(padding),
                width: double.infinity,
                child: const Center(
                    child: Text('Ethiopian Exchange Rate Data © 2024',
                        style: TextStyle(color: Colors.white))),
              ),
            ],
          );
        },
      ),
    );
  }
}
