import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final List<int> colors = [
    0xfffcba03,
    0xffd65336,
    0xff55fa23,
    0xff5ae6ce,
    0xff5090d9,
    0xff5343ba,
    0xffa545d1,
    0xffd149a8,
    0xffc4314c,
  ];
  final _formKey = GlobalKey<FormState>();
  final categoryTextController = TextEditingController();

  int selectedColor = 0xfffcba03;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: categoryTextController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Category',
                    ),
                    validator: (String? value) {
                      if (value == null) return 'Enter a category';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: colors
                        .map(
                          (e) => GestureDetector(
                            key: Key('$e'),
                            onTap: () {
                              setState(() {
                                selectedColor = e;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Color(e),
                                  border: Border.all(
                                    color: selectedColor == e
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 3,
                                  )),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final CategoriesCompanion categoriesCompanion =
                              CategoriesCompanion(
                                  color: drift.Value('$selectedColor'),
                                  category:
                                      drift.Value(categoryTextController.text));
                          BlocProvider.of<CategoryBloc>(context)
                              .add(AddCategory(category: categoriesCompanion));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Create'),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    categoryTextController.dispose();
    super.dispose();
  }
}
