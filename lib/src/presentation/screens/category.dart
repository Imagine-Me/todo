import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/presentation/widgets/category_card/card_main.dart';
import 'package:todo/src/presentation/widgets/category_form.dart';
import 'package:todo/src/presentation/widgets/layout.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  Widget floatingButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () => onFloatingButtonPressed(context, null),
        child: const Icon(Icons.add),
      );
    });
  }

  void onFloatingButtonPressed(
      context, CategoriesCompanion? categoriesCompanion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return CategoryForm(
          categoriesCompanion: categoriesCompanion,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      floatingButton: floatingButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final item = state.categories[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(color: Colors.redAccent),
                        key: Key(item.toString()),
                        child: CardMain(
                          color: int.parse(item.color),
                          category: item.category,
                          onTap: () {
                            final CategoriesCompanion categoriesCompanion =
                                CategoriesCompanion(
                              id: drift.Value(item.id),
                              category: drift.Value(item.category),
                              color: drift.Value(item.color),
                            );
                            onFloatingButtonPressed(
                                context, categoriesCompanion);
                          },
                        ),
                        onDismissed: (_) {
                          BlocProvider.of<CategoryBloc>(context).add(
                            DeleteCategory(
                              category: CategoriesCompanion(
                                id: drift.Value(item.id),
                                category: drift.Value(item.category),
                                color: drift.Value(item.color),
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
