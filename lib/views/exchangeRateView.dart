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

class _ExchangeRateViewState extends State<ExchangeRateView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTab = 'Exchange Rate';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _selectedTab = 'Exchange Rate';
            break;
          case 1:
            _selectedTab = 'News';
            break;
          case 2:
            _selectedTab = 'About Us';
            break;
          case 3:
            _selectedTab = 'Contact';
            break;
          default:
            _selectedTab = 'Exchange Rate';
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exchange Rates'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Exchange Rate'),
              Tab(text: 'News'),
              Tab(text: 'About Us'),
              Tab(text: 'Contact'),
            ],
          ),
        ),
        body: Consumer<ExchangeRateController>(
          builder: (context, controller, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double padding = screenWidth < 600 ? 8.0 : 16.0;
                double fontSize = screenWidth < 600 ? 14.0 : 20.0;

                return Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Tab 1: Best Transaction Rates
                          controller.token == null
                              ? const Center(
                                  child:
                                      CircularProgressIndicator())
                              : ListView(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(padding),
                                      child: Text(
                                        'Best Transaction Rates',
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (controller
                                        .allBanksBestExchangeRates.isNotEmpty)
                                      DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Currency')),
                                          DataColumn(label: Text('Buying')),
                                          DataColumn(label: Text('Selling')),
                                          DataColumn(label: Text('Bank')),
                                        ],
                                        rows: controller
                                            .allBanksBestExchangeRates
                                            .map<DataRow>((item) {
                                          return DataRow(cells: [
                                            DataCell(Text(item['currency'])),
                                            DataCell(Text(item['buying']
                                                    ['value']
                                                .toString())),
                                            DataCell(Text(item['selling']
                                                    ['value']
                                                .toString())),
                                            DataCell(
                                                Text(item['selling']['bank'])),
                                          ]);
                                        }).toList(),
                                      ),
                                  ],
                                ),
                          const NewsView(),
                          const AboutUsView(),
                          const ContactUsView(),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      width: double.infinity,
                      padding: EdgeInsets.all(padding),
                      // Adjust padding for responsiveness
                      child: Center(
                        child: Text(
                          'Ethiopian Exchange Rate Data © 2024',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 12.0 : 16.0,
                            // Adjust text size for small screens
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
