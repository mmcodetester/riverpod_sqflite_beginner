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
