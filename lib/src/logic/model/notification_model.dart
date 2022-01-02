class NotificationModel {
  final String notificaitonText;
  final String? firebaseToken;
  final String? notificationTime;

  NotificationModel(
      {required this.notificaitonText,
      this.firebaseToken,
      this.notificationTime});

  Map<String, String> toJson() => {
        'notification_text': notificaitonText,
        'firebase_id': firebaseToken ?? '',
        'notification_time': notificationTime ?? ''
      };
}
