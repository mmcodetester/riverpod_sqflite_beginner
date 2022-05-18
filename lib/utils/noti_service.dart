import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
//import 'package:provider_app/models/daily_paln_submodule.dart';
import 'package:provider_app/utils/plan_db.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications() async {
    DateTime today = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(today);
    //_notificationService.showNotifications();
    final data =
        await PlanDatabase.instance.getAllDailyUncompletePlanSubModule(date);

    if (data.isNotEmpty) {
      int count = 0;
      String txtstr = '';
      data.forEach((element) {
        if (!element.isComplete!) {
          count += 1;
        }
      });
      if (count > 0) {
        txtstr = "You have " + count.toString() + " plan today!";
      } else {
        txtstr = "You Have No Plan Today";
      }
      await flutterLocalNotificationsPlugin.show(
        0,
        "Planner",
        txtstr,
        NotificationDetails(android: _androidNotificationDetails),
      );
    }

    //print(data.length);

    // if (data.length > 0) {

    // }
  }

  Future<void> scheduleNotifications(int length) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Your Plan Today",
        "You have " + length.toString() + "tasks to complete today",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String payload) async {
  //handle your logic here
}
