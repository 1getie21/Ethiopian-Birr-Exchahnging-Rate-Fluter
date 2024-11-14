import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exchangeRateController.dart';

class ExchangeRateView extends StatelessWidget {
  const ExchangeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (currency) {
              Provider.of<ExchangeRateController>(context, listen: false)
                  .updateSelectedCurrency(currency);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'USD', child: Text('USD')),
              PopupMenuItem(value: 'EURO', child: Text('EURO')),
              PopupMenuItem(value: 'GBP', child: Text('GBP')),
              PopupMenuItem(value: 'AED', child: Text('AED')),
              PopupMenuItem(value: 'YUAN', child: Text('YUAN')),
            ],
          ),
        ],
      ),
      body: Consumer<ExchangeRateController>(
        builder: (context, controller, _) {
          return controller.token == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Exchange Rates for ${controller.selectedCurrency}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Bank')),
                  DataColumn(label: Text('Buying')),
                  DataColumn(label: Text('Selling')),
                  DataColumn(label: Text('Change')),
                ],
                rows: controller.filteredExchangeRates.map<DataRow>((item) {
                  return DataRow(cells: [
                    DataCell(Text(item['bank'] ?? 'N/A')),
                    DataCell(Text(item['buying']['value'].toString())),
                    DataCell(Text(item['selling']['value'].toString())),
                    DataCell(Text(item['change'] ?? 'N/A')),
                  ]);
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
