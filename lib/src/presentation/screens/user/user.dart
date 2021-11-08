import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/logic/model/pie_chart_model.dart';
import 'package:todo/src/presentation/screens/user/components/user_form.dart';
import 'package:todo/src/presentation/widgets/layout.dart';
import 'package:todo/src/presentation/widgets/pie_chart_widget.dart';

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  Map<String, double> dataMap = {};
  List<Color> colorList = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    List<Todo> todos = await database.getTodos();
    CategoryState categoryState = BlocProvider.of<CategoryBloc>(context).state;
    final PieChartModel pieChartModel = PieChartModel();
    pieChartModel.todos = todos;
    pieChartModel.category = categoryState;
    setState(() {
      dataMap = pieChartModel.dataMap;
      colorList = pieChartModel.colorList;
    });
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  key: const Key('user_name_edit'),
                  onPressed: () => showEditModal(context),
                  icon: const Icon(Icons.edit))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'OVERVIEW',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 50,
          ),
          if (dataMap.isNotEmpty)
            PieChartWidget(
              dataMap: dataMap,
              colorList: colorList,
            )
        ],
      ),
      floatingButton: null,
    );
  }
}
