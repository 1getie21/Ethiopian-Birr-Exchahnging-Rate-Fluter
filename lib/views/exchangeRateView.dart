import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exchangeRateController.dart';

class ExchangeRateView extends StatefulWidget {
  const ExchangeRateView({super.key});

  @override
  _ExchangeRateViewState createState() => _ExchangeRateViewState();
}

class _ExchangeRateViewState extends State<ExchangeRateView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExchangeRateController>(context, listen: false)
          .fetchExchangeRatesTest();

      // Provider.of<ExchangeRateController>(context, listen: false)
      //     .fetchExchangeRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ethiopian Exchange Rates'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'USD'),
            Tab(text: 'EUR'),
            Tab(text: 'GBP'),
          ],
          onTap: (index) {
            String selectedCurrency = ['USD', 'EUR', 'GBP'][index];
            Provider.of<ExchangeRateController>(context, listen: false)
                .updateSelectedCurrency(selectedCurrency);
          },
        ),
      ),

      backgroundColor: Colors.blue,
      body: Consumer<ExchangeRateController>(
        builder: (context, controller, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildExchangeRateTable(controller),
              _buildExchangeRateTable(controller),
              _buildExchangeRateTable(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExchangeRateTable(ExchangeRateController controller) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('Bank')),
            DataColumn(label: Text('Buying')),
            DataColumn(label: Text('Selling')),
          ],
          rows: controller.filteredExchangeRates.map<DataRow>((bank) {
            return DataRow(
              cells: [
                // DataCell(Text(bank['bank'])),
                // DataCell(Text(bank['rates'][0]['buying'].toString())),
                // DataCell(Text(bank['rates'][0]['selling'].toString())),

                DataCell(Container(color: Colors.white, child: Text(bank['bank']))),
                DataCell(Container(color: Colors.white, child: Text(bank['rates'][0]['buying'].toString()))),
                DataCell(Container(color: Colors.white, child: Text(bank['rates'][0]['selling'].toString()))),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
