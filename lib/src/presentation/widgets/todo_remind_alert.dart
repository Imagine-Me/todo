import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RemindMeAlert extends StatefulWidget {
  const RemindMeAlert({Key? key, required this.onRemindFormSubmit, this.selectedRemindMe})
      : super(key: key);

  final Function(Map<String, DateTime>?) onRemindFormSubmit;
  final Map<String, DateTime>? selectedRemindMe;
  @override
  State<RemindMeAlert> createState() => _RemindMeAlertState();
}

class _RemindMeAlertState extends State<RemindMeAlert> {
  String? selectedDay;
  DateTime? selectedDate;
  late final DateTime createDate;

  Map<String, DateTime>? selectedRemindMe;

  late final List<Map<String, DateTime>> dayList;

  @override
  void initState() {
    super.initState();
    createDate = DateTime.now();
    selectedRemindMe = widget.selectedRemindMe;
    dayList = [
      {'Remind me in 1 day': createDate.add(const Duration(days: 1))},
      {'Remind me in 2 days': createDate.add(const Duration(days: 2))},
      {'Remind me in 3 days': createDate.add(const Duration(days: 3))},
    ];
  }

  void onSubmit() {
    Navigator.pop(context, 'OK');
    widget.onRemindFormSubmit(selectedRemindMe);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select reminder'),
      content: Wrap(
        children: [
          ...dayList.map((day) => ListTile(
                title: Text(day.keys.first),
                tileColor: selectedRemindMe != null &&
                        (day.keys.first == selectedRemindMe!.keys.first)
                    ? Colors.red
                    : null,
                onTap: () {
                  if (mapEquals(selectedRemindMe, day)) {
                    setState(() {
                      selectedRemindMe = null;
                    });
                  } else {
                    setState(() {
                      selectedRemindMe = day;
                    });
                  }
                },
              )),
          ListTile(
            title: selectedRemindMe != null &&
                    (!selectedRemindMe!.keys.first.contains('day'))
                ? Text(selectedRemindMe!.keys.first)
                : const Text('Select custom date'),
            tileColor: selectedRemindMe != null &&
                    (!selectedRemindMe!.keys.first.contains('day'))
                ? Colors.red
                : null,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101));
              if (picked != null && selectedDate != picked) {
                setState(() {
                  selectedRemindMe = {
                    'Remind me on ${DateFormat('yyyy-MM-dd').format(picked)}':
                        picked
                  };
                });
              }
              if (picked == null) {
                setState(() {
                  selectedRemindMe = null;
                });
              }
            },
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSubmit,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
