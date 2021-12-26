import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';


// this is just for text
class NotificationService {

  NotificationService._internal();

  static final NotificationService _notificationService = NotificationService
      ._internal();

  factory NotificationService(){
    return _notificationService;
  }

  Future<void> initialize() async {
    AwesomeNotifications().initialize(
      'android/app/src/main/res/drawable/img.png',
      [
        NotificationChannel(
          channelKey: 'bird_schedule_channel',
          channelName: 'CheckBird notification',
          defaultColor: Colors.lightBlueAccent,
          locked: true,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );
  }

  Future<void> createInstantNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'CheckBird_test_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }


  Future<void> createScheduleNotification(int id, String title,
      String body, DateTime dateTime, bool reapeat) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'CheckBird_schedule_channel',
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
      schedule: NotificationCalendar.fromDate(date: dateTime, repeats: reapeat),
    );
  }

  Future<void> cancelScheduledNotifications(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
