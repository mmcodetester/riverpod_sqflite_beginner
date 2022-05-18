import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/daily_plan_sub_module.dart';

//import '../providers/daily_plan_sub_module.dart';

class UncompletePage extends ConsumerStatefulWidget {
  const UncompletePage({Key? key}) : super(key: key);

  @override
  ConsumerState<UncompletePage> createState() => _UncompletePageState();
}

class _UncompletePageState extends ConsumerState<UncompletePage> {
  DateTime date = DateTime.now();
  String today = '';
  @override
  void initState() {
    today = DateFormat('yyyy-MM-dd').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dailyPlanSubModuleProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: Text(
            "UNSUCCESS PLANS TODAY",
            style: TextStyle(letterSpacing: 1),
          )),
      body: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return item.name != null &&
                        !item.isComplete! &&
                        item.date == today
                    ? Card(
                        child: ListTile(
                            title: Text(
                              item.name.toString(),
                              style: const TextStyle(
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            trailing: IconButton(
                                color: item.isComplete!
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                onPressed: () {
                                  // print(item.id);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6.0))),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 20),
                                                child: Center(
                                                  child: Text(
                                                    "You Complete This Plan ?",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 20),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.warning_amber,
                                                  size: 50,
                                                  color: Colors.redAccent,
                                                )),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 20),
                                                    child: Center(
                                                      child: ElevatedButton(
                                                          //color: Colors.amber,
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.amber,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Cancel")),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 20),
                                                    child: Center(
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (item
                                                                  .isComplete!) {
                                                                item.isComplete =
                                                                    false;
                                                              } else {
                                                                item.isComplete =
                                                                    true;
                                                              }
                                                              ref
                                                                  .watch(dailyPlanSubModuleProvider
                                                                      .notifier)
                                                                  .update(item);
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            });
                                                          },
                                                          child: Text("OK")),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: item.isComplete!
                                    ? const Icon(Icons.done)
                                    : const Icon(Icons.close)),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(item.date.toString(),
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 14)),
                                ),
                              ],
                            )),
                      )
                    : const SizedBox();
              })
          : const Center(
              child: Text(
                "NO UNSUCCESS PLAN TODAY !",
                style: TextStyle(fontSize: 14),
              ),
            ),
    );
  }
}
