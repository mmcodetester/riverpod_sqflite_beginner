import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/pages/sub_module/daily_plan_details_page.dart';
import 'package:provider_app/pages/daily_plan/daily_plan_page.dart';
import 'package:provider_app/pages/home_page.dart';
import 'package:provider_app/pages/user/profile_page.dart';
import 'package:provider_app/utils/noti_service.dart';
import 'package:workmanager/workmanager.dart';

import 'pages/sub_module/complete_plan_page.dart';
import 'pages/sub_module/uncomplete_module.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    NotificationService _notificationService = NotificationService();

    await _notificationService.showNotifications();

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
      // The top level function, aka callbackDispatcher
      callbackDispatcher,
      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  await NotificationService().init();
  Map<String, dynamic>? data = {"Plan": "You have plan today?"};
  Workmanager().registerPeriodicTask("1", "daily plan",
      frequency: Duration(hours: 4), inputData: data);
  runApp(ProviderScope(
      child: MaterialApp(
    theme: ThemeData(fontFamily: 'Pyidaunsu', backgroundColor: Colors.white),
    initialRoute: '/',
    routes: {
      '/': (_) => const SplashScreen(),
      '/home': (_) => const HomePage(),
      '/dailyplan': (_) => const DailyPlanPage(),
      '/dailyplanlist': (_) => const DailyPlanDetails(),
      '/uncompletePlan': (_) => const UncompletePage(),
      '/completePlan': (_) => const CompletePage(),
      '/user': (_) => ProfilePage(),
    },
    debugShowCheckedModeBanner: false,
  )));
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    //Navigator.pushNamed(context, '/home');

    Future.delayed(const Duration(seconds: 2),
        () => Navigator.popAndPushNamed(context, '/home'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Image.asset(
          'images/logo_to_do.png',
          fit: BoxFit.cover,
        )));
  }
}
