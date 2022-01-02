import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/src/constants/enum.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/presentation/widgets/snackbar.dart';
import 'package:todo/src/presentation/widgets/todo_remind_alert.dart';
import 'package:todo/src/resources/utils.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key, this.todosCompanion}) : super(key: key);

  final TodosCompanion? todosCompanion;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late final TextEditingController titleTextController;
  final _formKey = GlobalKey<FormState>();

  Map<String, DateTime>? remindMeDate;

  int? selectedCategory;
  @override
  void initState() {
    super.initState();
    if (widget.todosCompanion != null) {
      titleTextController =
          TextEditingController(text: widget.todosCompanion!.title.value);
      selectedCategory = widget.todosCompanion!.category.value;
      final DateTime? remindAt = widget.todosCompanion!.remindAt.value;
      if (remindAt != null) {
        final int days =
            daysBetween(widget.todosCompanion!.isCreatedAt.value!, remindAt);
        setState(() {
          remindMeDate = getInitialRemind(days, remindAt);
        });
      }
    } else {
      titleTextController = TextEditingController();
    }
  }

  Map<String, DateTime> getInitialRemind(int days, DateTime date) {
    switch (days) {
      case 1:
        return {'Remind me in 1 day': date};
      case 2:
        return {'Remind me in 2 days': date};
      case 3:
        return {'Remind me in 3 days': date};
      default:
        return {'Remind me on ${DateFormat('yyyy-MM-dd').format(date)}': date};
    }
  }

  TodosCompanion getTodosCompanion() {
    TodosCompanion todosCompanion = TodosCompanion(
      category: drift.Value(selectedCategory),
      title: drift.Value(titleTextController.text),
      remindAt: remindMeDate == null
          ? const drift.Value(null)
          : drift.Value(remindMeDate![remindMeDate!.keys.first]!.toUtc()),
      isCreatedAt: drift.Value(DateTime.now().toUtc()),
    );

    if (widget.todosCompanion != null) {
      todosCompanion = todosCompanion.copyWith(
          id: widget.todosCompanion!.id,
          isCreatedAt: widget.todosCompanion!.isCreatedAt,
          notification: widget.todosCompanion!.notification);
    }

    return todosCompanion;
  }

  onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<TodoBloc>(context)
          .add(AddTodo(todosCompanion: getTodosCompanion()));
      Navigator.of(context).pop();
      if (widget.todosCompanion != null) {
        showCustomSnackbar(context, 'Todo Updated', SnackBarType.primary);
      } else {
        showCustomSnackbar(context, 'Todo Added', SnackBarType.success);
      }
    }
  }

  void selectRemindMeDate(Map<String, DateTime>? dateTime) {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      remindMeDate = dateTime;
    });
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    key: const Key('todo_form_title'),
                    keyboardType: TextInputType.multiline,
                    controller: titleTextController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    minLines: 1,
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
                  GestureDetector(
                    key: const Key('todo_form_remind_me'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => RemindMeAlert(
                                onRemindFormSubmit: selectRemindMeDate,
                                selectedRemindMe: remindMeDate,
                              ));
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: remindMeDate == null
                              ? const Text('Remind me')
                              : Text(remindMeDate!.keys.last)),
                    ),
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
