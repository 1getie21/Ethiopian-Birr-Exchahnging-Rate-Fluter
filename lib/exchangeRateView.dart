import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exchangeRateController.dart';

class ExchangeRateView extends StatelessWidget {
  const ExchangeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
      ),
      body: Consumer<ExchangeRateController>(
        builder: (context, controller, child) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Best Transaction Rates',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              if (controller.allBanksBestExchangeRates.isNotEmpty)
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('Buying')),
                    DataColumn(label: Text('Selling')),
                    DataColumn(label: Text('Bank')),
                  ],
                  rows: controller.allBanksBestExchangeRates
                      .map<DataRow>((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['currency'])),
                      DataCell(Text(item['buying']['value'].toString())),
                      DataCell(Text(item['selling']['value'].toString())),
                      DataCell(Text(item['selling']['bank'])),
                    ]);
                  }).toList(),
                ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'All Banks Exchange Rates',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              if (controller.allBankExchangeRates.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.allBankExchangeRates.length,
                  itemBuilder: (context, index) {
                    final item = controller.allBankExchangeRates[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  item['bank_logo'],
                                  width: 100,
                                  height: 50,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${item['bank_name']} (${item['bank_id']}) Transaction Rate',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            DataTable(
                              columns: const [
                                DataColumn(label: Text('Code')),
                                DataColumn(label: Text('Buying')),
                                DataColumn(label: Text('Selling')),
                                DataColumn(label: Text('Spread')),
                              ],
                              rows: (item['rate'] as List).map<DataRow>((rate) {
                                final spread =
                                (rate['selling'] - rate['buying']).toString();
                                return DataRow(cells: [
                                  DataCell(Text(rate['base'])),
                                  DataCell(Text(rate['buying'].toString())),
                                  DataCell(Text(rate['selling'].toString())),
                                  DataCell(Text(spread)),
                                ]);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
