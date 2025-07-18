import 'package:flutter/material.dart';

import 'customWidget/container.dart';

class AppBar_T extends StatefulWidget {
  const AppBar_T({super.key});

  @override
  State<AppBar_T> createState() => _AppBar_TState();
}

class _AppBar_TState extends State<AppBar_T> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState(){
    _tabController=TabController(length: 3, vsync:this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize:25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              // letterSpacing: 3,
              height: 10,
              shadows: [
                Shadow(
                    offset: Offset(0, 15),
                    blurRadius: .1,
                    color: Colors.limeAccent
                )
              ]
          ),),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        elevation: 400,
        shadowColor: Colors.deepOrangeAccent,
        toolbarOpacity: .6,
        // toolbarHeight: 100.9,
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.favorite),
          IconButton(onPressed: (){
            print('this is iconButton');
          },icon:Icon(Icons.search))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.person),
              text: 'Person',),
            Tab(icon: Icon(Icons.card_travel),
              text: 'Travel',),
            Tab(icon: Icon(Icons.shopping_cart),
              text: 'Shopping',)
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Row(
          children: [
            MyCustomContainer(
              text:'Maha',
              TextCo: Colors.white,
              Height: 100,
              Width: 80,
              color: Colors.amberAccent,
              borderColor: Colors.black87,

            ),
            SizedBox(width:10,),
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
    );
  }
}