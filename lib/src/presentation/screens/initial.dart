import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/presentation/widgets/animation/blinking_text.dart';
import 'package:todo/src/presentation/widgets/animation/todo_loader/todo_loader.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          Navigator.of(context).popAndPushNamed('/');
        }
      },
      builder: (context, state) {
        if (state is UserNotFound) {
          return const FormWidget();
        }
        return const LoadingWidget();
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/splash_logo.png'),
          ),
          Positioned(
            bottom: 12,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const BlinkingText(
                text: Text(
                  'LOADING',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.topLeft,
          image: AssetImage('assets/form_background.png'),
          fit: BoxFit.fitWidth,
        )),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(children: [
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Image(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/todo.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const TodoLoader(color: Colors.white,)
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameTextEditingController,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            errorStyle: TextStyle(color: Colors.blueAccent)),
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
                    child: Icon(
                      Icons.skip_next,
                      color: Theme.of(context).primaryColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      primary: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
