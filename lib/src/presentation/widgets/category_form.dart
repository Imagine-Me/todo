import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key, this.categoriesCompanion}) : super(key: key);

  final CategoriesCompanion? categoriesCompanion;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  late final TextEditingController categoryTextController;
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
    0xffff4554,
    0xff85fffb,
    0xff6a1ce8
  ];
  final _formKey = GlobalKey<FormState>();
  late int selectedColor;
  @override
  void initState() {
    super.initState();
    categoryTextController = TextEditingController(
        text: widget.categoriesCompanion == null
            ? ''
            : widget.categoriesCompanion!.category.value);
    selectedColor = widget.categoriesCompanion == null
        ? 0xfffcba03
        : int.parse(widget.categoriesCompanion!.color.value);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Padding(
        padding: MediaQuery.of(context).viewInsets,
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
                      if (value == null || value == '') {
                        return 'Enter a category';
                      }
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
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 10),
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
                          CategoriesCompanion categoriesCompanion =
                              CategoriesCompanion(
                            id: widget.categoriesCompanion == null
                                ? drift.Value.absent()
                                : widget.categoriesCompanion!.id,
                            color: drift.Value('$selectedColor'),
                            category:
                                drift.Value(categoryTextController.text),
                          );

                          BlocProvider.of<CategoryBloc>(context)
                              .add(AddCategory(category: categoriesCompanion));
                          Navigator.of(context).pop();
                        }
                      },
                      child: widget.categoriesCompanion == null
                          ? const Text('Create')
                          : const Text('Update'),
                    ),
                  )
                ],
              )),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    categoryTextController.dispose();
    super.dispose();
  }
}
