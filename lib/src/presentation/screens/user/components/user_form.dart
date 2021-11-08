import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late final TextEditingController nameTextController;

  void onSubmitForm(){
    final UsersCompanion companion = widget.user.toCompanion(true).copyWith(name: drift.Value(nameTextController.text));
    BlocProvider.of<UserBloc>(context).add(AddUser(usersCompanion: companion));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('user_form_name'),
                    keyboardType: TextInputType.multiline,
                    controller: nameTextController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 12,
                    maxLines: 3,
                    minLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value == '') {
                        return 'Enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key('todo_form_submit_button'),
                      onPressed: () => onSubmitForm(),
                      child: const Text('Update'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
