import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/presentation/screens/user/components/user_form.dart';
import 'package:todo/src/presentation/widgets/layout.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  showEditModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return UserForm(
            user: BlocProvider.of<UserBloc>(context).state.user!,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Text(
                    'Hi ${state.name}',
                    style: Theme.of(context).textTheme.headline2,
                  );
                },
              ),
              IconButton(
                  onPressed: () => showEditModal(context),
                  icon: const Icon(Icons.edit))
            ],
          )
        ],
      ),
      floatingButton: null,
    );
  }
}
