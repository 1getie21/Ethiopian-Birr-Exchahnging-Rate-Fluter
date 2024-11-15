import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exchangeRateController.dart';

class AllBanksExchangeRateView extends StatefulWidget {
  const AllBanksExchangeRateView({super.key});

  @override
  _AllBanksExchangeRateState createState() => _AllBanksExchangeRateState();
}

class _AllBanksExchangeRateState extends State<AllBanksExchangeRateView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 4 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<ExchangeRateController>(
            builder: (context, controller, _) {
              final padding =
                  MediaQuery.of(context).size.width < 600 ? 8.0 : 16.0;
              return Column(
                children: [
                  Expanded(
                    child: controller.token == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            padding: EdgeInsets.all(padding),
                            children: [
                              if (controller
                                  .allBanksBestExchangeRates.isNotEmpty)
                                DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Currency')),
                                    DataColumn(label: Text('Buying')),
                                    DataColumn(label: Text('Selling')),
                                    DataColumn(label: Text('Change')),
                                  ],
                                  rows: controller.allBanksBestExchangeRates
                                      .map<DataRow>((item) => DataRow(cells: [
                                            DataCell(Container(
                                              color: Colors.white,
                                              width: 35,
                                              child: Text(
                                                  item['currency'].toString()),
                                            )),
                                            DataCell(Container(
                                              color: Colors.white,
                                              width: 65,
                                              child: Text(item['buying']
                                                      ['value']
                                                  .toString()),
                                            )),
                                            DataCell(Container(
                                              color: Colors.white,
                                              width: 65,
                                              child: Text(item['selling']
                                                      ['value']
                                                  .toString()),
                                            )),
                                            DataCell(
                                                Text(item['selling']['bank'])),
                                          ]))
                                      .toList(),
                                ),
                              Container(
                                color: Colors.blue,
                                padding: EdgeInsets.all(padding),
                                width: double.infinity,
                                child: const Center(
                                    child: Text(
                                        'Ethiopian Exchange Rate Data © 2024')),
                              ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
