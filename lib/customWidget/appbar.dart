import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabController? tabController;
  final List<Tab>? tabs;

  const MyCustomAppBar({
    Key? key,
    required this.title,
    this.tabController,
    this.tabs,
  }) : super(key: key);

  @override
  Size get preferredSize => tabs != null
      ? const Size.fromHeight(120) // TabBar সহ
      : const Size.fromHeight(70); // শুধু AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.teal,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 3,
              color: Colors.black26,
            ),
          ],
        ),
      ),
      leading: Icon(Icons.menu),
      actions: [
        Icon(Icons.notifications),
        IconButton(
          onPressed: () {
            print("Search tapped");
          },
          icon: Icon(Icons.search),
        ),
      ],
      bottom: (tabs != null && tabController != null)
          ? TabBar(
        controller: tabController,
        tabs: tabs!,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
      )
          : null,
    );
  }
}
