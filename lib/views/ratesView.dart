import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/views/allBanksExchangeRate.dart';
import 'package:untitled/views/exchangeRateView.dart';
import 'aboutUsView.dart';
import 'contactUsView.dart';
import '../exchangeRateController.dart';
import 'newsView.dart';

class RatesView extends StatefulWidget {
  const RatesView({super.key});

  @override
  _RatesViewState createState() => _RatesViewState();
}

class _RatesViewState extends State<RatesView>
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
      appBar: AppBar(
        // title: const Text('Exchange Rates'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: ''),
            Tab(text: 'Home'),
            Tab(text: 'News'),
            Tab(text: 'About Us'),
            Tab(text: 'Contact'),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Home - Exchange Rates view
          AllBanksExchangeRateView(),
          // Home - Exchange Rates view
          ExchangeRateView(),
          // News view
          NewsView(),
          // About Us view
          AboutUsView(),
          // Contact Us view
          ContactUsView(),
        ],
      ),
    );
  }
}
