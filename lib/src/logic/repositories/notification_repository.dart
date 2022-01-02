import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/src/logic/model/notification_model.dart';

class NotificationRepository {
  Future<void> addNotification(NotificationModel notificationModel) async {
    final url = Uri.parse('http://192.168.1.5:4000/v1/post');
    await http.post(
      url,
      body: json.encode(notificationModel.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  }
}
