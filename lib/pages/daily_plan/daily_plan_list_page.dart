import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/providers/daily_plan_provider.dart';

import '../../providers/daily_plan_sub_module.dart';

class DailyPlanListPage extends ConsumerWidget {
  const DailyPlanListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.refresh(dailyPlanProvider.notifier);
    final data = ref.watch(dailyPlanProvider);

    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return item.name != null
                  ? Card(
                      child: ListTile(
                          trailing: IconButton(
                              color: Colors.redAccent,
                              icon: Icon(Icons.delete_rounded),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0))),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30, horizontal: 10),
                                            child: const Text(
                                              //'Please rate with star',
                                              'Do You Sure To Delete!',
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.yellow),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Calcel",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .watch(dailyPlanProvider
                                                            .notifier)
                                                        .delete(item.id!);
                                                    ref
                                                        .watch(
                                                            dailyPlanSubModuleProvider
                                                                .notifier)
                                                        .delete(item.id!);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "OK",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },

                                  //print('After dialog');
                                  //Navigator.pop(context);
                                );
                              }),
                          title: Text(
                            item.name.toString(),
                            style: const TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              item.description != null
                                  ? Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        item.description!,
                                        style: const TextStyle(
                                            color: Colors.cyan, fontSize: 15),
                                      ),
                                    )
                                  : const SizedBox(),
                              item.islearning!
                                  ? Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        "Learning Plan",
                                        style: const TextStyle(
                                            color: Colors.brown, fontSize: 14),
                                      ),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Text(
                                    'From Date : ' +
                                        item.fromdate.toString() +
                                        ' To Date : ' +
                                        item.todate.toString(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey, fontSize: 14)),
                              ),
                            ],
                          )),
                    )
                  : const SizedBox();
            })
        : const Center(
            child: Text("No Data In List"),
          );
  }
}
