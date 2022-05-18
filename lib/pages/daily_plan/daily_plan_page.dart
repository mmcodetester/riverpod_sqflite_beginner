import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/pages/daily_plan/daily_plan_entry_page.dart';
import 'package:provider_app/pages/daily_plan/daily_plan_list_page.dart';

//import 'daily_plan_sub_module_helper.dart';

class DailyPlanPage extends ConsumerStatefulWidget {
  const DailyPlanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyPlanPage> createState() => _DailyPlanPageState();
}

class _DailyPlanPageState extends ConsumerState<DailyPlanPage> {
  static int currentIndex = 0;
  final screens = const [
    DailyPlanListPage(),
    //DailyPlanSubModuleHelper(),
    DailyPlanEntryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.indigo,
        title: const Text(
          "MAIN PLAN",
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Main Plan List',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.date_range_outlined),
          //   label: 'Plan Details',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_sharp),
            label: 'Add Plan',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepOrange,
        selectedIconTheme: const IconThemeData(size: 20),
        unselectedItemColor: Colors.indigo,
        iconSize: 18,
        selectedFontSize: 16,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
