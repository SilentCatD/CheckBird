import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final String _channelKey = 'CheckBird_schedule_channel';

  Future<void> initialize() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: 'CheckBird notification',
          defaultColor: Colors.lightBlueAccent,
          locked: true,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          soundSource: 'resource://raw/res_custom_notification_sound',
          channelDescription: 'CheckBird notification',
        ),
      ],
    );
  }

  Future<void> createInstantNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: _channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  Future<void> createScheduleNotification(
      int id, String title, String body, DateTime dateTime, bool repeat) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: _channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
        ),
      ],
      schedule: NotificationCalendar.fromDate(date: dateTime, repeats: repeat),
    );
  }

  Future<void> cancelScheduledNotifications(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
