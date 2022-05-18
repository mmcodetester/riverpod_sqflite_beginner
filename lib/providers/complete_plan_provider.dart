// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';
//import 'package:provider_app/providers/uncomplete_submodule_provider.dart';
import 'package:provider_app/utils/plan_db.dart';

final completeSubModuleProvider = StateNotifierProvider.autoDispose<
    GetDailyPlanSubModule,
    List<DailyPlanSubModule>>((ref) => GetDailyPlanSubModule(ref));

class GetDailyPlanSubModule extends StateNotifier<List<DailyPlanSubModule>> {
  GetDailyPlanSubModule(Ref ref) : super([]) {
    // ref.watch(uncompleteSubModuleProvider);
    getallDailyPlanSubModule();
  }
  getallDailyPlanSubModule() async {
    DateTime today = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(today);
    final plan = [];
    final plans =
        await PlanDatabase.instance.getAllDailyUncompletePlanSubModule(date);
    plans.forEach((element) {
      if (element.isComplete!) {
        plan.add(element);
      }
    });
    state = [];
    state = [...plan];
  }

  update(DailyPlanSubModule module) async {
    DateTime today = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(today);
    final data = await PlanDatabase.instance.updateSubModule(module);
    final note = [];
    final notes =
        await PlanDatabase.instance.getAllDailyUncompletePlanSubModule(date);
    notes.forEach((element) {
      if (element.isComplete!) {
        note.add(element);
      }
    });
    //print(note);
    state = [];
    state = [...note];
    //state.where((element) => element.isComplete == 0);
  }
}
