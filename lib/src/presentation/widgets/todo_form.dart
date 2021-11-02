import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key, this.todosCompanion}) : super(key: key);

  final TodosCompanion? todosCompanion;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late final TextEditingController titleTextController;
  final _formKey = GlobalKey<FormState>();

  int? selectedCategory;
  @override
  void initState() {
    super.initState();
    if (widget.todosCompanion != null) {
      titleTextController =
          TextEditingController(text: widget.todosCompanion!.title.value);
      selectedCategory = widget.todosCompanion!.category.value;
    } else {
      titleTextController = TextEditingController();
    }
  }

  onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      final TodosCompanion todosCompanion = TodosCompanion(
        id: widget.todosCompanion == null
            ? const drift.Value.absent()
            : widget.todosCompanion!.id,
        category: drift.Value(selectedCategory),
        title: drift.Value(titleTextController.text),
        isCreatedAt: widget.todosCompanion == null
              ? drift.Value(DateTime.now().toUtc())
              : widget.todosCompanion!.isCreatedAt,
      );
      BlocProvider.of<TodoBloc>(context)
          .add(AddTodo(todosCompanion: todosCompanion));
      Navigator.of(context).pop();
      if (widget.todosCompanion != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Todo Updated', style: TextStyle(color: Colors.black)),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.yellowAccent,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Todo Added',
            ),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.greenAccent,
          ),
        );
      }
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
                    key: const Key('todo_form_title'),
                    controller: titleTextController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Task',
                    ),
                    validator: (String? value) {
                      if (value == null || value == '') {
                        return 'Enter a task';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<TodoBloc, TodoState>(
                      builder: (context, state) {
                        return DropdownButtonFormField(
                          key: const Key('todo_form_category'),
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
                          items: state.categoryState.categories
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
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key('todo_form_submit_button'),
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
    super.dispose();
  }
}
