import 'package:flutter/material.dart';

import 'package:todo/src/presentation/widgets/app_bar.dart' as custom_app_bar;

class Layout extends StatelessWidget {
  const Layout({Key? key, required this.body, required this.floatingButton})
      : super(key: key);

  final Widget body;
  final Widget floatingButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Category'),
              onTap: () {
                Navigator.of(context).pushNamed('/category');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const custom_app_bar.AppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: body,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingButton,
    );
  }
}
