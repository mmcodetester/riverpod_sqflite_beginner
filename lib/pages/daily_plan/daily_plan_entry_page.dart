// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/models/daily_plan_model.dart';
import 'package:provider_app/utils/plan_db.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/daily_paln_submodule.dart';
import '../../providers/daily_plan_sub_module.dart';
import '../../utils/date_helper.dart';

class DailyPlanEntryPage extends ConsumerStatefulWidget {
  const DailyPlanEntryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyPlanEntryPage> createState() => _DailyPlanEntryPageState();
}

class _DailyPlanEntryPageState extends ConsumerState<DailyPlanEntryPage> {
  late String name = '';
  late String startDate = '';
  late String endDate = '';
  late String description = '';
  late bool isLearnig = false;
  bool isChecked = false;
  final nameController = TextEditingController();
  final descController = TextEditingController();
  @override
  void initState() {
    var today = DateTime.now();
    name = '';
    startDate = DateFormat('dd-MM-yyyy').format(today);
    endDate =
        DateFormat('dd-MM-yyyy').format(today.add(const Duration(days: 7)));
    isLearnig = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearTextFiled() {
    descController.text = '';
    nameController.text = '';
    name = '';
    description = '';
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value.startDate.toString().isNotEmpty &&
        args.value.startDate != null) {
      startDate =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
    }
    if (args.value.endDate.toString().isNotEmpty &&
        args.value.endDate != null) {
      endDate = DateFormat('yyyy-MM-dd').format(args.value.endDate).toString();
    }
  }

  void onchangeNameText(String value) {
    name = value;
  }

  void onchangeDescriptionText(String value) {
    description = value;
  }

  @override
  Widget build(BuildContext context) {
    //final data = ref.watch(dailyPlanProvider.notifier);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Name",
              ),
              onChanged: (val) {
                onchangeNameText(val);
              },
              //iconColor: Colors.redAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: TextFormField(
              controller: descController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Description",
              ),
              onChanged: (val) {
                onchangeDescriptionText(val);
              },
              //iconColor: Colors.redAccent),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text("Is Learning"),
              Checkbox(
                value: isChecked,
                activeColor: Colors.redAccent,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                    isLearnig = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text("Cancel"),
                  )),
              ElevatedButton(
                  onPressed: () {
                    var plan = DailyPlan(
                        name: name,
                        description: description,
                        fromdate: startDate,
                        todate: endDate,
                        islearning: isLearnig);

                    PlanDatabase.instance.createDailyPlan(plan).then((value) {
                      //print(value.id);
                      List<DateTime> dateList = getDaysInBeteween(
                          DateTime.parse(
                              plan.fromdate.toString() + " 00:00:00"),
                          DateTime.parse(plan.todate.toString() + " 00:00:00"));
                      dateList.forEach((element) {
                        var data = DailyPlanSubModule(
                            name: plan.name,
                            dailyplanid: value.id,
                            date: DateFormat('yyyy-MM-dd')
                                .format(element)
                                .toString(),
                            isComplete: false);
                        ref
                            .watch(dailyPlanSubModuleProvider.notifier)
                            .createDailyPlanSubModule(data);
                        // PlanDatabase.instance.createDailyPlanSubModule(data);
                        //print(data);
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 10),
                                  child: const Text(
                                    //'Please rate with star',
                                    'Save Success Plan',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    'images/true.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    clearTextFiled();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: Colors.green,
                                    alignment: Alignment.center,
                                    height: 40,
                                    //color: primaryColor,
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },

                        //print('After dialog');
                        //Navigator.pop(context);
                      );
                    });
                  },
                  child: const Center(
                    child: Text("Save Plan"),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Select Multiple Date"),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
        ],
      ),
    );
  }
}
