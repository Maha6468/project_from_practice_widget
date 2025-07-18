import 'package:flutter/material.dart';

import 'customWidget/appbar.dart';
import 'customWidget/container.dart';

class AppBar_T extends StatefulWidget {
  const AppBar_T({super.key});

  @override
  State<AppBar_T> createState() => _AppBar_TState();
}

class _AppBar_TState extends State<AppBar_T> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: 'Custom AppBar',
        tabController: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.person), text: 'Person'),
          Tab(icon: Icon(Icons.card_travel), text: 'Travel'),
          Tab(icon: Icon(Icons.shopping_cart), text: 'Shopping'),
        ],
      ),
      body:

      TabBarView(
      controller: _tabController,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              MyCustomContainer(
                text: 'Maha',
                TextCo: Colors.white,
                Height: 100,
                Width: 80,
                color: Colors.amberAccent,
                borderColor: Colors.black87,
              ),
              SizedBox(width: 10),
              MyCustomContainer(
                text: 'Mahabubar',
                TextCo: Colors.limeAccent,
                Height: 120,
                Width: 80,
                color: Colors.pink,
                borderColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
        Center(child: Text('Travel Tab')),
        Center(child: Text('Shopping Tab')),
      ],
    ),

    );
  }
}
