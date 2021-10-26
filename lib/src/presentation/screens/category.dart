import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/presentation/widgets/category_card/card_main.dart';
import 'package:todo/src/presentation/widgets/category_form.dart';
import 'package:todo/src/presentation/widgets/layout.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  Widget floatingButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () => onFloatingButtonPressed(context),
        child: const Icon(Icons.add),
      );
    });
  }

  void onFloatingButtonPressed(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CategoryForm();
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
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.categoriesOrdered.length,
                    itemBuilder: (context, index) {
                      return CardMain(
                        color: int.parse(state.categoriesOrdered[index].color),
                        category: state.categoriesOrdered[index].category,
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
