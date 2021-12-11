import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:todo/src/resources/utils.dart';

class NotificationClass {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('todo_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        selectNotificationSubject.add(payload);
      }
    });
  }
}

Future<void> scheduleNotification(
    {required int id,
    required String title,
    required String body,
    required DateTime scheduledTime}) async {
  const int insistentFlag = 4;

  await NotificationClass.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AndroidNotificationChannel(
        title,
        'ScheduledNotification_blah',
        importance: Importance.defaultImportance,
        description: 'THIS IS THE DESCRIPTION',
      ));

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    title,
    'ScheduledNotification_blah',
    icon: 'todo_launcher',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
    playSound: true,
    channelShowBadge: true,
    usesChronometer: true,
    ticker: 'ticker',
    additionalFlags: Int32List.fromList(<int>[insistentFlag]),
    sound: const RawResourceAndroidNotificationSound('todo_notification'),
  );

  final NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

  tz.TZDateTime time;
  if (daysBetween(DateTime.now(), scheduledTime) == 0) {
    time = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));
  } else {
    time = tz.TZDateTime.from(scheduledTime, tz.local);
  }
  await NotificationClass.flutterLocalNotificationsPlugin.zonedSchedule(
      id, title, body, time, notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
  print('SCHEDULED A NOTIFICATION ON $time');
}
