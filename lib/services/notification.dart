import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'check_bird',
    'CheckBird',
    importance: Importance.max,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound("res_custom_notification_sound"),
  );

  static const NotificationDetails _notificationDetails =
      NotificationDetails(android: _androidNotificationDetails);

  factory NotificationService() {
    return _notificationService;
  }

  Future<void> requestPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> createInstantNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      (title + body).hashCode,
      title,
      body,
      _notificationDetails,
    );
  }

  Future<void> createScheduleNotification(
      int id, String title, String body, DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      _notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelScheduledNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
