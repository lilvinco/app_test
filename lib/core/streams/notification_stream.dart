import 'package:flutter/cupertino.dart';
import 'package:igroove_fan_box_one/model/notifications/notification.dart';

class NotificationsValueListenable {
  final ValueNotifier<List<NotificationModel>> notifications =
      ValueNotifier<List<NotificationModel>>([]);
  final ValueNotifier<int> unseenNotifications = ValueNotifier<int>(0);

  // Add to notifications
  void addToNotifications(NotificationModel notification) {
    List<NotificationModel> _notifications = notifications.value;
    _notifications.add(notification);
    notifications.value = _notifications;
  }

  // Remove from notifications
  void removeFromNotifications(NotificationModel notification) {
    List<NotificationModel> _notifications = notifications.value;
    _notifications.remove(notification);
  }
}
