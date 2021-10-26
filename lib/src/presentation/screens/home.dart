import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return Text('Category length : ${state.categories.length}');
            },
          ),
          ElevatedButton(
              onPressed: () {
                const CategoriesCompanion category = CategoriesCompanion(
                    category: drift.Value('Business'),
                    color: drift.Value('0xffFF0000'));
                BlocProvider.of<CategoryBloc>(context)
                    .add(AddCategory(category: category));
              },
              child: Text('Create New Category'))
        ],
      ),
    );
  }
}
