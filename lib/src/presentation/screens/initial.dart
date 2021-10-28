import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/user_bloc.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameTextEditingController = TextEditingController();

  onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      final userCompanion =
          UsersCompanion(name: drift.Value(nameTextEditingController.text));
      BlocProvider.of<UserBloc>(context)
          .add(AddUser(usersCompanion: userCompanion));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UserLoaded) {
          Navigator.of(context).popAndPushNamed('/');
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: nameTextEditingController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(hintText: 'Enter Name'),
                      validator: (String? val) {
                        if (val == null || val == '') {
                          return 'Enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: onSubmitForm,
                  child: const Icon(Icons.skip_next),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
