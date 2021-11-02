import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RemindMeAlert extends StatefulWidget {
  const RemindMeAlert({Key? key, required this.onRemindFormSubmit})
      : super(key: key);

  final Function(Map<String, DateTime>?) onRemindFormSubmit;

  @override
  State<RemindMeAlert> createState() => _RemindMeAlertState();
}

class _RemindMeAlertState extends State<RemindMeAlert> {
  String? selectedDay;
  DateTime? selectedDate;

  Widget tile(String title) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedDate = null;
        });
        if (title == selectedDay) {
          setState(() {
            selectedDay = null;
          });
        } else {
          setState(() {
            selectedDay = title;
          });
        }
      },
      tileColor: selectedDay == title ? Colors.red : null,
      title: Text(title),
    );
  }

  void onSubmit() {
    Navigator.pop(context, 'OK');
    if (selectedDay != null) {
      switch (selectedDay) {
        case 'In 1 day':
          widget.onRemindFormSubmit({
            'Remind me in 1 day': DateTime.now().add(const Duration(days: 1))
          });
          break;
        case 'In 2 days':
          widget.onRemindFormSubmit({
            'Remind me in 2 day': DateTime.now().add(const Duration(days: 2))
          });
          break;
        case 'In 3 days':
          widget.onRemindFormSubmit({
            'Remind me in 3 day': DateTime.now().add(const Duration(days: 3))
          });
          break;
      }
    } else if (selectedDate != null) {
      widget.onRemindFormSubmit({
        'Remind me on ${DateFormat('yyyy-MM-dd').format(selectedDate!)}':
            selectedDate!
      });
    } else {
      widget.onRemindFormSubmit(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select reminder'),
      content: Wrap(
        children: [
          tile('In 1 day'),
          tile('In 2 days'),
          tile('In 3 days'),
          ListTile(
            title: selectedDate == null
                ? const Text('Select custom date')
                : Text('On ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'),
            tileColor: selectedDate == null ? null : Colors.red,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101));
              if (picked != null && selectedDate != picked) {
                setState(() {
                  selectedDay = null;
                  selectedDate = picked;
                });
              }
              if (picked == null) {
                setState(() {
                  selectedDate = null;
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
