import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/constants/enum.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';

class TodoFilterAlert extends StatefulWidget {
  const TodoFilterAlert({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(BuildContext, String?, OrderTypes) onSubmit;
  @override
  State<TodoFilterAlert> createState() => _TodoFilterAlertState();
}

class _TodoFilterAlertState extends State<TodoFilterAlert> {
  String? filterValue;
  OrderTypes orderValue = OrderTypes.created;

  @override
  void initState() {
    TodoFilter filter = BlocProvider.of<TodoBloc>(context).state.todoFilter;
    orderValue = filter.orderTypes;
    if(filter.filterBycompleted !=null && filter.filterBycompleted!){
      filterValue = 'completed';
    }
    if(filter.filterBycompleted !=null && !filter.filterBycompleted!){
      filterValue = 'uncompleted';
    }
    super.initState();
  }

  Widget listFilterRadio(String title, String value) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.1,
          child: Radio<String>(
            value: value,
            groupValue: filterValue,
            toggleable: true,
            onChanged: (String? val) {
              setState(() {
                filterValue = val;
              });
            },
          ),
        ),
        Text(title),
      ],
    );
  }

  Widget listOrderRadio(String title, OrderTypes value) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.1,
          child: Radio<OrderTypes>(
            value: value,
            groupValue: orderValue,
            toggleable: true,
            onChanged: (OrderTypes? val) {
              setState(() {
                orderValue = val ?? OrderTypes.created;
              });
            },
          ),
        ),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      content: Wrap(
        children: <Widget>[
          Text(
            'FILTER',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 5,
          ),
          listFilterRadio('Show uncompleted', 'uncompleted'),
          listFilterRadio('Show completed', 'completed'),
          const SizedBox(
            height: 5,
          ),
          Text(
            'ORDER',
            style: Theme.of(context).textTheme.headline6,
          ),
          listOrderRadio('Order by created date', OrderTypes.created),
          listOrderRadio('Order by remind date', OrderTypes.remind),
          listOrderRadio('Group by category', OrderTypes.category),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  widget.onSubmit(context, filterValue, orderValue);
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Filter'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
