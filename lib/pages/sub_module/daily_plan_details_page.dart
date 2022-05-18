// import 'package:flutter/material.dart';

// class DailyPlanDetails extends StatelessWidget {
//   const DailyPlanDetails({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/pages/sub_module/sub_module_edit.dart';

import '../../providers/daily_plan_sub_module.dart';

class DailyPlanDetails extends ConsumerStatefulWidget {
  const DailyPlanDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyPlanDetails> createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends ConsumerState<DailyPlanDetails> {
  bool _serchVisible = false;
  bool _isSearch = false;
  late var data = [];
  @override
  void initState() {
    data = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(dailyPlanSubModuleProvider);
    void filterSearchResult(String query) {
      if (query.isNotEmpty) {
        _isSearch = true;
        setState(() {
          data = list
              .where((item) =>
                  item.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
          // print(data.length);
        });
      } else {
        data.clear();
        setState(() {
          _isSearch = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _serchVisible = !_serchVisible;
                  });
                },
                icon: Icon(Icons.search)),
          )
        ],
        title: Text(
          "PLAN LIST",
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          _serchVisible
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResult(value);
                      // ref
                      //     .watch(dailyPlanSubModuleProvider.notifier)
                      //     .search(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              this._serchVisible = false;
                              this._isSearch = false;
                            });
                          },
                          icon: Icon(Icons.clear, color: Colors.indigo)),
                    ),
                  ),
                )
              : SizedBox(),
          Expanded(
              child: list.isNotEmpty && _isSearch == false
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return item.name != null
                            ? Card(
                                child: ListTile(
                                    leading: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SubModuleEdit(id: item.id!),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit_note,
                                          color: Colors.grey,
                                        )),
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
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0))),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 20),
                                                        child: Center(
                                                          child: Text(
                                                            "Are You Sure To Change ?",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 20),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.warning_amber,
                                                          size: 50,
                                                          color:
                                                              Colors.redAccent,
                                                        )),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 20),
                                                            child: Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      //color: Colors.amber,
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.amber,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Cancel")),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 20),
                                                            child: Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (item
                                                                            .isComplete!) {
                                                                          item.isComplete =
                                                                              false;
                                                                        } else {
                                                                          item.isComplete =
                                                                              true;
                                                                        }
                                                                        ref.watch(dailyPlanSubModuleProvider.notifier).update(
                                                                            item);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "OK")),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        item.whynot != null
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1),
                                                child: Text(
                                                    item.whynot.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 14)),
                                              )
                                            : SizedBox(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
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
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return item.name != null
                            ? Card(
                                child: ListTile(
                                    leading: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SubModuleEdit(id: item.id!),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit_note,
                                          color: Colors.grey,
                                        )),
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
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6.0))),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 20),
                                                        child: Center(
                                                          child: Text(
                                                            "Are You Sure To Change ?",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 20),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.warning_amber,
                                                          size: 50,
                                                          color:
                                                              Colors.redAccent,
                                                        )),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 20),
                                                            child: Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      //color: Colors.amber,
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.amber,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Cancel")),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 20),
                                                            child: Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (item
                                                                            .isComplete!) {
                                                                          item.isComplete =
                                                                              false;
                                                                        } else {
                                                                          item.isComplete =
                                                                              true;
                                                                        }
                                                                        ref.watch(dailyPlanSubModuleProvider.notifier).update(
                                                                            item);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "OK")),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        item.whynot != null
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1),
                                                child: Text(
                                                    item.whynot.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 14)),
                                              )
                                            : SizedBox(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text(item.date.toString(),
                                              style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    )),
                              )
                            : const SizedBox();
                      })),
        ],
      ),
    );
  }
}
