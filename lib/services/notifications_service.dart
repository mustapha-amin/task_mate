import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> scheduleTaskNotification(
      String? title, String? body, DateTime selectedTime) async {
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.getLocation('Africa/Lagos'));
    try {
      await _notificationsPlugin.show(
          10,
          "title",
          "body",
          NotificationDetails(
            android: AndroidNotificationDetails(
              'simple_notification_channel', // channel ID
              'Simple Notifications', // channel Name
              channelDescription:
                  'This channel is used for simple notifications',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
            ),
          ));
      // await _notificationsPlugin.zonedSchedule(
      //   1,
      //   title,
      //   body,
      //   scheduledTime,
      //   _notificationDetails(),
      //   uiLocalNotificationDateInterpretation:
      //       UILocalNotificationDateInterpretation.absoluteTime,
      //   matchDateTimeComponents: DateTimeComponents.dateAndTime,
      // );

      debugPrint('Notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    );
  }
}
