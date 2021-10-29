import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/user_bloc.dart';
import 'package:todo/src/presentation/routes/todo_router.dart';

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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      state.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                Navigator.of(context).pop();
                TodoRouter.pushRoute('/', context);
              },
            ),
            ListTile(
              title: Text(
                'Category',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                Navigator.of(context).pop();
                TodoRouter.pushRoute('/category', context);
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
