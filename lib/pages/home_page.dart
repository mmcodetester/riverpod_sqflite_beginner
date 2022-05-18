import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/providers/user/user_provider.dart';
import '../models/user/user_model.dart';
import '../providers/daily_plan_sub_module.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime date = DateTime.now();

  String today = '';
  @override
  void initState() {
    today = DateFormat('yyyy-MM-dd').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalData = ref.watch(dailyPlanSubModuleProvider);
    User user = User();
    //final completeall = ref.watch(completeda
    //ilyPlanSubModuleProvider);

    final userdata = ref.watch(userProvider);
    if (userdata.isNotEmpty) {
      userdata.forEach((element) {
        user.id = element.id;
        user.gender = element.gender;
        user.name = element.name;
        user.image = element.image;
      });
    }
    int uncompleteAll = 0;
    int completeAll = 0;
    int totalAll = 0;
    int finalCompleteALl = 0;
    int finalUncompleteAll = 0;
    if (totalData.isNotEmpty) {
      totalData.forEach((element) {
        // print(element.date);

        if (element.date == today) {
          totalAll += 1;
        }
        if (element.isComplete! && element.date == today) {
          completeAll += 1;
        } else if (!element.isComplete! && element.date == today) {
          uncompleteAll += 1;
        }
        if (element.isComplete!) {
          finalCompleteALl += 1;
        } else if (!element.isComplete!) {
          finalUncompleteAll += 1;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user');
                  },
                  icon: Icon(Icons.settings)),
            )
          ],
          leading: Icon(
            Icons.segment_outlined,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigo,
          title: const Text(
            "PLAN YOUR GOALS",
            style:
                TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(80)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 10, 20),
                      child: Text(
                        "Create Your Life Success",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8.0),
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 0,
                            elevation: 0,
                            highlightElevation: 0,
                            textColor: Colors.pink,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text(DateFormat.MMM()
                                        .format(date)
                                        .toUpperCase())),
                                SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text(DateFormat.d()
                                        .format(date)
                                        .toUpperCase()))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 40, 0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.EEEE().format(date).toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "TODAY",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipOval(
                                      child: user.image != null
                                          ? Image.asset(
                                              "images/" + user.image.toString(),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "images/men.png",
                                              fit: BoxFit.cover,
                                            ),
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                            child: Text(
                              user.name != null
                                  ? user.name.toString()
                                  : 'User Name',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                  fontStyle: FontStyle.normal,
                                  //fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                              child: user.gender == 'male'
                                  ? Icon(
                                      Icons.male_sharp,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.female_sharp,
                                      color: Colors.pink,
                                    ))
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child: Text(
                                  "TOTAL",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      letterSpacing: 1),
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipOval(
                                          child: Center(
                                              child: totalAll != 0
                                                  ? Text(totalAll.toString())
                                                  : Text('0'))))),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "SUCCESS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      letterSpacing: 1),
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipOval(
                                          child: Center(
                                              child: completeAll != 0
                                                  ? Text(completeAll.toString())
                                                  : Text('0'))))),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "UNSUCCESS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      letterSpacing: 1),
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.redAccent,
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipOval(
                                          child: Center(
                                              child: uncompleteAll != 0
                                                  ? Text(
                                                      uncompleteAll.toString())
                                                  : Text('0'))))),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  //color: Colors.black87,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/dailyplan');
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 170,
                                  //height: 80,
                                  // color: Colors.cyan,
                                  padding: EdgeInsets.all(20.0),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent.withOpacity(0.7),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Opacity(
                                    opacity: 0.3,
                                    child: Icon(Icons.edit_calendar,
                                        size: 40, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   Icons.calendar_month,
                                      //   color: Colors.white,
                                      //   size: 28,
                                      // ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Plan Entry",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/completePlan');
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 170,
                                  // height: 80,
                                  // color: Colors.cyan,
                                  padding: EdgeInsets.all(20.0),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Opacity(
                                    opacity: 0.3,
                                    child: Icon(Icons.check,
                                        size: 40, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   Icons.calendar_month,
                                      //   color: Colors.white,
                                      //   size: 28,
                                      // ),

                                      Text(
                                        "Success\nToday",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/dailyplanlist');
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 170,
                              height: 80,
                              // color: Colors.cyan,
                              padding: EdgeInsets.all(15.0),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Opacity(
                                opacity: 0.3,
                                child: Icon(Icons.calendar_month,
                                    size: 40, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Plan List ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/uncompletePlan');
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 170,
                              height: 80,
                              // color: Colors.cyan,
                              padding: EdgeInsets.all(20.0),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Opacity(
                                opacity: 0.3,
                                child: Icon(Icons.clear,
                                    size: 40, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Unsuccess\nToday",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80)),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 10, 0, 0),
                          child: Text(
                            "YOUR PLANS",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Text(totalData.length.toString()),
                              backgroundColor: Colors.grey.shade100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total Plan",
                                style: TextStyle(color: Colors.amber.shade100),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              child: Text(finalCompleteALl.toString()),
                              backgroundColor: Colors.grey.shade100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Success Plan",
                                style: TextStyle(color: Colors.amber.shade100),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              child: Text(finalUncompleteAll.toString()),
                              backgroundColor: Colors.grey.shade100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Unsuccess Plan",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
