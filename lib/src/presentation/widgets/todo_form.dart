import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key, required this.categories, this.todosCompanion})
      : super(key: key);

  final TodosCompanion? todosCompanion;
  final List<Category> categories;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late final TextEditingController titleTextController;
  late final TextEditingController contentTextController;
  final _formKey = GlobalKey<FormState>();

  int? selectedCategory;
  @override
  void initState() {
    super.initState();
    if (widget.todosCompanion != null) {
      titleTextController =
          TextEditingController(text: widget.todosCompanion!.title.value);
      contentTextController =
          TextEditingController(text: widget.todosCompanion!.content.value);
      selectedCategory = widget.todosCompanion!.category.value;
    } else {
      titleTextController = TextEditingController();
      contentTextController = TextEditingController();
    }
  }

  onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      final TodosCompanion todosCompanion = TodosCompanion(
          id: widget.todosCompanion == null
              ? const drift.Value.absent()
              : widget.todosCompanion!.id,
          category: drift.Value(selectedCategory),
          content: drift.Value(contentTextController.text),
          title: drift.Value(titleTextController.text));
      BlocProvider.of<TodoBloc>(context)
          .add(AddTodo(todosCompanion: todosCompanion));
      Navigator.of(context).pop();
    }
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
                    controller: titleTextController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Title',
                    ),
                    validator: (String? value) {
                      if (value == null || value == '') {
                        return 'Enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: contentTextController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Content',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      validator: (int? val) {
                        if (val == null) {
                          return 'Please select category';
                        }
                        return null;
                      },
                      hint: const Text('Select a category'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: widget.categories
                          .map((e) => DropdownMenuItem(
                                value: e.id,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      color: Color(int.parse(e.color)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(e.category)
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (int? val) {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          selectedCategory = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => onSubmitForm(),
                      child: widget.todosCompanion == null
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
    titleTextController.dispose();
    contentTextController.dispose();
    super.dispose();
  }
}
