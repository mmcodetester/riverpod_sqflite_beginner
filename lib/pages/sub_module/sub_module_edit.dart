import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/providers/daily_plan_sub_module.dart';
import 'package:provider_app/providers/daily_plan_sub_module/daily_plan_edit_provider.dart';

class SubModuleEdit extends ConsumerWidget {
  SubModuleEdit({Key? key, required this.id}) : super(key: key);
  final int id;
  final nameController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(dailyPlanEditProvider(id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Edit Sub Module",
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      body: result.when(
          data: (data) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                    child: TextFormField(
                      initialValue: data.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Plan Name",
                      ),
                      onChanged: (val) {
                        data.name = val;
                      },
                      //iconColor: Colors.redAccent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: TextFormField(
                      initialValue: data.whynot,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Not Complete Why Not",
                      ),
                      onChanged: (val) {
                        data.whynot = val;
                      },
                      //iconColor: Colors.redAccent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: TextFormField(
                      initialValue: data.date,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "No Complete Why Not",
                      ),
                      onChanged: (val) {
                        data.date = val;
                      },
                      //iconColor: Colors.redAccent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 49, 49, 47),
                              minimumSize: Size(80, 40),
                            ),
                            onPressed: () {},
                            child: Text("Cancel")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              minimumSize: Size(80, 40),
                            ),
                            onPressed: () {
                              ref
                                  .watch(dailyPlanSubModuleProvider.notifier)
                                  .update(data);
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
                            },
                            child: Text("Save "))
                      ],
                    ),
                  )
                ],
              ),
          error: (err, stack) => Center(),
          loading: () => CircularProgressIndicator()),
    );
  }
}
